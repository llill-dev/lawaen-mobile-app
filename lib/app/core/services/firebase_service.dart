import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
/// Store payload and handle it on next app start/resume if needed.
@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse response) {
  // Keep this minimal and safe.
  // If you want: save response.payload into SharedPreferences/AppPreferences.
  log('[LocalNotif] Background tap payload: ${response.payload}');
}

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    // 1) Permissions (iOS)
    await _firebaseMessaging.requestPermission(alert: true, badge: true, sound: true);

    // 2) Token
    await _saveDeviceToken();
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      log("[FCM] Token Refreshed: $newToken");
      await getIt<AppPreferences>().saveFcmToken(newToken);
    });

    // 3) Local notifications init (tap handler included)
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
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      log("[FCM] Notification Clicked (terminated): ${initialMessage.data}");

      final appRouter = getIt<AppRouter>();
      await NotificationNavigationHelper.handle(router: appRouter, data: initialMessage.data);
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

      /// Handles taps on local notifications (foreground case)
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        final payload = response.payload;
        if (payload == null || payload.isEmpty) return;

        Map<String, dynamic> data;

        // Prefer full JSON payload (message.data). Fallback to treating as "screen".
        try {
          final decoded = jsonDecode(payload);
          if (decoded is Map) {
            data = decoded.map((k, v) => MapEntry(k.toString(), v));
          } else {
            data = {"screen": payload};
          }
        } catch (_) {
          data = {"screen": payload};
        }

        final appRouter = getIt<AppRouter>();
        await NotificationNavigationHelper.handle(router: appRouter, data: data);
      },

      /// MUST be a top-level/static entry point; no closures here.
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
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
}
