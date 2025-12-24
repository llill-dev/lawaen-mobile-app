// notification_navigation_helper.dart
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:lawaen/app/routes/router.dart';
import 'package:lawaen/app/routes/router.gr.dart';

class NotificationNavigationHelper {
  NotificationNavigationHelper._();

  /// Call this from `onMessageOpenedApp` (and from `getInitialMessage()` on cold start).
  /// Expected keys in [data]:
  /// - "screen": e.g. "/item/<subCategoryId>/<itemId>"
  /// - OR "deeplink": e.g. "lawaen://notification?screen=%2Fitem%2F...%2F..."
  static Future<void> handle({required AppRouter router, required Map<String, dynamic> data}) async {
    final screen = _extractScreen(data);
    if (screen == null || screen.isEmpty) {
      log('[NotifNav] No screen in data: $data');
      return;
    }

    final uri = Uri.tryParse(screen.startsWith('/') ? 'app://local$screen' : screen);
    if (uri == null) {
      log('[NotifNav] Could not parse screen: $screen');
      return;
    }

    final path = uri.path;
    final segments = uri.pathSegments;

    try {
      switch (path) {
        case '/navigation_controller':
          await router.push(NavigationControllerRoute());
          return;

        case '/notifications':
          await router.push(const NotificationRoute());
          return;

        case '/add_missing_place':
          await router.push(const AddMissingPlaceRoute());
          return;

        case '/onboarding':
          await router.push(const OnboardingRoute());
          return;

        case '/login':
          await router.push(const LoginRoute());
          return;

        case '/register':
          await router.push(const RegisterRoute());
          return;

        case '/profile':
          await router.push(const ProfileRoute());
          return;

        case '/ratings':
          await router.push(const RatingsRoute());
          return;

        case '/favorites':
          await router.push(const FavoritesRoute());
          return;

        case '/contact_us':
          await router.push(const ContactUsRoute());
          return;

        case '/update_profile':
          await router.push(const UpdateProfileRoute());
          return;

        case '/map_nearby':
          await router.push(const NearbyMapRoute());
          return;
      }

      /// =========================
      /// Dynamic path handling
      /// =========================

      ///notification_details/:id
      // if (segments.length == 2 && segments.first == 'notification_details') {
      //   final id = segments[1];
      //   if (id.isEmpty) {
      //     log('[NotifNav] Missing id for notification_details');
      //     return;
      //   }
      //   await router.push(NotificationDetailsRoute(id: id));
      //   return;
      // }

      // /category_details/:id
      if (segments.length == 2 && segments.first == 'category_details') {
        final categoryId = segments[1];
        if (categoryId.isEmpty) {
          log('[NotifNav] Missing categoryId for category_details');
          return;
        }
        await router.push(CategoryDetailsRoute(categoryId: categoryId));
        return;
      }

      // /menu/:subCategoryId/:id
      if (segments.length == 3 && segments.first == 'menu') {
        final subCategoryId = segments[1];
        final itemId = segments[2];

        if (subCategoryId.isEmpty || itemId.isEmpty) {
          log('[NotifNav] Invalid menu route: $segments');
          return;
        }

        await router.push(MuneRoute(secondId: subCategoryId, itemId: itemId));
        return;
      }

      // /feedback_chat/:subCategoryId/:id
      if (segments.length == 3 && segments.first == 'feedback_chat') {
        final subCategoryId = segments[1];
        final itemId = segments[2];

        if (subCategoryId.isEmpty || itemId.isEmpty) {
          log('[NotifNav] Invalid feedback_chat route: $segments');
          return;
        }

        await router.push(FeedbackChatRoute(secondCategoryId: subCategoryId, itemId: itemId));
        return;
      }

      // /claim/:subCategoryId/:id
      if (segments.length == 3 && segments.first == 'claim') {
        final subCategoryId = segments[1];
        final itemId = segments[2];

        if (subCategoryId.isEmpty || itemId.isEmpty) {
          log('[NotifNav] Invalid claim route: $segments');
          return;
        }

        await router.push(ClaimRoute(secondCategoryId: subCategoryId, itemId: itemId));
        return;
      }

      // /event_details/:id
      // if (segments.length == 2 && segments.first == 'event_details') {
      //   final eventId = segments[1];
      //   if (eventId.isEmpty) {
      //     log('[NotifNav] Missing eventId for event_details');
      //     return;
      //   }

      //   await router.push(EventsDetailsRoute(id: eventId));
      //   return;
      // }

      // Existing: /item/:subCategoryId/:itemId
      if (segments.length == 3 && segments.first == 'item') {
        final subCategoryId = segments[1];
        final itemId = segments[2];

        if (subCategoryId.isEmpty || itemId.isEmpty) {
          log('[NotifNav] Invalid item route segments: $segments');
          return;
        }

        await router.push(CategoryItemDetialsRoute(subCategoryId: subCategoryId, itemId: itemId));
        return;
      }

      log('[NotifNav] Unhandled path: $path (full: $screen), data=$data');
    } catch (e, st) {
      log('[NotifNav] Navigation error: $e', stackTrace: st);
    }
  }

  static String? _extractScreen(Map<String, dynamic> data) {
    final rawScreen = _asString(data['screen'])?.trim();
    if (rawScreen != null && rawScreen.isNotEmpty) return rawScreen;

    final deeplink = _asString(data['deeplink'])?.trim();
    if (deeplink == null || deeplink.isEmpty) return null;

    final uri = Uri.tryParse(deeplink);
    if (uri == null) return null;

    // supports lawaen://notification?screen=%2Fitem%2F...%2F...
    final screenFromQuery = uri.queryParameters['screen']?.trim();
    if (screenFromQuery != null && screenFromQuery.isNotEmpty) return screenFromQuery;

    // sometimes you may send the path directly as the deeplink path
    if (uri.path.isNotEmpty) return uri.path;

    return null;
  }

  static String? _asString(Object? v) {
    if (v == null) return null;
    if (v is String) return v;
    // Handles numbers/bools coming as dynamic
    return describeEnum(v) == v.toString() ? v.toString() : v.toString();
  }
}
