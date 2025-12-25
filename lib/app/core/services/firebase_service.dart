import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/app_prefs.dart';
import 'package:lawaen/app/core/services/notification_navigation_helper.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/routes/router.dart';

/// Background FCM handler (must be top-level)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('[FCM] Background Message: ${message.notification?.title}');
  log('[FCM] Background Data: ${message.data}');
}

/// Background tap handler for flutter_local_notifications (must be top-level)
/// NOTE: Do not try to navigate here; app UI may not be ready.
@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse response) {
  log('[LocalNotif] Background tap payload: ${response.payload}');
}

@Singleton()
class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  static const String _pendingNavKey = "pending_notification_nav";

  Future<void> initialize() async {
    // 1) Permissions (iOS)
    await _firebaseMessaging.requestPermission(alert: true, badge: true, sound: true);

    // 2) Token
    await _saveDeviceToken();
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      log("[FCM] Token Refreshed: $newToken");
      await getIt<AppPreferences>().saveFcmToken(newToken);
    });

    // 3) Local notifications init (tap handler included) + cold start check
    await _initializeLocalNotifications();

    // 4) Background handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // 5) Foreground messages: show local notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log("[FCM] Foreground Message Title: ${message.notification?.title}");
      log("[FCM] Foreground Message Data: ${message.data}");
      await _showLocalNotification(message);
    });

    // 6) App opened from notification (background -> foreground)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      log("[FCM] Notification Clicked (background): ${message.notification?.title}");
      log("[FCM] Click Data: ${message.data}");

      final appRouter = getIt<AppRouter>();
      await NotificationNavigationHelper.handle(router: appRouter, data: message.data);
    });

    // 7) App opened from notification (terminated)
    // IMPORTANT: store only. UI/router may not be ready yet.
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      log("[FCM] Notification Clicked (terminated): ${initialMessage.data}");
      await _storePendingNavigationData(initialMessage.data);
    }
  }

  Future<void> _saveDeviceToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      log("[FCM] Token: $token");
      if (token != null && token.isNotEmpty) {
        await getIt<AppPreferences>().saveFcmToken(token);
      }
    } catch (e) {
      log("[FCM] Error fetching token: $e");
    }
  }

  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final InitializationSettings initSettings = InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _localNotifications.initialize(
      initSettings,

      /// Handles taps on local notifications while app is alive/backgrounded
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        final payload = response.payload;
        if (payload == null || payload.isEmpty) return;

        final data = _decodePayloadToData(payload);

        final appRouter = getIt<AppRouter>();
        await NotificationNavigationHelper.handle(router: appRouter, data: data);
      },

      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    // Cold start from tapping a local notification (terminated)
    final launchDetails = await _localNotifications.getNotificationAppLaunchDetails();
    final response = launchDetails?.notificationResponse;

    if (launchDetails?.didNotificationLaunchApp == true && response?.payload?.isNotEmpty == true) {
      log('[LocalNotif] Launched from terminated via local notification: ${response!.payload}');
      await getIt<AppPreferences>().setString(prefsKey: _pendingNavKey, value: response.payload!);
    }
  }

  Map<String, dynamic> _decodePayloadToData(String payload) {
    // Prefer full JSON payload (message.data). Fallback to treating as "screen".
    try {
      final decoded = jsonDecode(payload);
      if (decoded is Map) {
        return decoded.map((k, v) => MapEntry(k.toString(), v));
      }
      return {"screen": payload};
    } catch (_) {
      return {"screen": payload};
    }
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails details = NotificationDetails(android: androidDetails);

    // Send full data map as JSON so screen/deeplink parsing works
    final payload = jsonEncode(message.data);

    // Use unique id so notifications don’t overwrite each other
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    await _localNotifications.show(
      id,
      message.notification?.title,
      message.notification?.body,
      details,
      payload: payload,
    );
  }

  Future<void> _storePendingNavigationData(Map<String, dynamic> data) async {
    await getIt<AppPreferences>().setString(prefsKey: _pendingNavKey, value: jsonEncode(data));
  }

  Future<Map<String, dynamic>?> takePendingNavigationData() async {
    final raw = getIt<AppPreferences>().getString(prefsKey: _pendingNavKey);
    if (raw.isEmpty) return null;

    await getIt<AppPreferences>().remove(prefsKey: _pendingNavKey);

    final decoded = jsonDecode(raw);
    if (decoded is Map) {
      return decoded.map((k, v) => MapEntry(k.toString(), v));
    }
    return null;
  }
}
