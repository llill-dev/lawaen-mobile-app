import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:lawaen/app/routes/router.dart';
import 'package:lawaen/app/routes/router.gr.dart';

class NotificationNavigationHelper {
  NotificationNavigationHelper._();

  /// Foreground / background: push target only (existing behavior).
  static Future<void> handle({required AppRouter router, required Map<String, dynamic> data}) async {
    final screen = _extractScreen(data);

    // Default fallback if no screen provided
    if (screen == null || screen.isEmpty) {
      log('[NotifNav] No screen found in payload, defaulting to /notifications');
      await router.push(const NotificationRoute());
      return;
    }

    final routes = _buildRoutesForScreen(screen);

    // Default fallback if screen not mapped
    if (routes.isEmpty) {
      log('[NotifNav] Unhandled screen "$screen", defaulting to /notifications');
      await router.push(const NotificationRoute());
      return;
    }

    try {
      // Push sequentially if multiple
      for (final r in routes) {
        await router.push(r);
      }
    } catch (e, st) {
      log('[NotifNav] Navigation error: $e', stackTrace: st);
    }
  }

  /// Terminated cold start: build proper back stack (Home/NavController -> target).
  /// This prevents back button crash/empty-stack.
  static Future<void> handleColdStart({required AppRouter router, required Map<String, dynamic> data}) async {
    final screen = _extractScreen(data);

    // Default fallback if no screen provided
    if (screen == null || screen.isEmpty) {
      log('[NotifNav] No screen found in payload, defaulting to /notifications (cold start)');
      await router.replaceAll([NavigationControllerRoute(), const NotificationRoute()]);
      return;
    }

    final routes = _buildRoutesForScreen(screen);

    // Default fallback if screen not mapped
    if (routes.isEmpty) {
      log('[NotifNav] Unhandled screen "$screen", defaulting to /notifications (cold start)');
      await router.replaceAll([NavigationControllerRoute(), const NotificationRoute()]);
      return;
    }

    // Ensure NavigationController is below the target route
    final stack = <PageRouteInfo>[
      NavigationControllerRoute(),
      ...routes.where((r) => r.routeName != NavigationControllerRoute.name),
    ];

    try {
      await router.replaceAll(stack);
    } catch (e, st) {
      log('[NotifNav] ColdStart navigation error: $e', stackTrace: st);
    }
  }

  /// =========================
  /// Screen parsing
  /// =========================
  static String? _extractScreen(Map<String, dynamic> data) {
    final rawScreen = data['screen'];
    if (rawScreen is String && rawScreen.trim().isNotEmpty) {
      return rawScreen.trim();
    }

    // Optional: accept 'deeplink' as well
    final deeplink = data['deeplink'];
    if (deeplink is String && deeplink.trim().isNotEmpty) {
      final uri = Uri.tryParse(deeplink.trim());
      if (uri != null) {
        final fromQuery = uri.queryParameters['screen'];
        if (fromQuery != null && fromQuery.trim().isNotEmpty) return fromQuery.trim();
        if (uri.path.isNotEmpty) return uri.path;
      }
    }

    return null;
  }

  /// =========================
  /// Route mapping
  /// =========================
  static List<PageRouteInfo> _buildRoutesForScreen(String screen) {
    // Support both "/path" and "scheme://host/path"
    final uri = Uri.tryParse(screen.startsWith('/') ? 'app://local$screen' : screen);
    if (uri == null) return const [];

    final path = uri.path;
    final segments = uri.pathSegments;

    /// =========================
    /// Static routes
    /// =========================
    switch (path) {
      case '/navigation_controller':
        return [NavigationControllerRoute()];

      case '/notifications':
        return [const NotificationRoute()];

      case '/add_missing_place':
        return [const AddMissingPlaceRoute()];

      case '/onboarding':
        return [const OnboardingRoute()];

      case '/login':
        return [const LoginRoute()];

      case '/register':
        return [const RegisterRoute()];

      case '/profile':
        return [const ProfileRoute()];

      case '/ratings':
        return [const RatingsRoute()];

      case '/favorites':
        return [const FavoritesRoute()];

      case '/contact_us':
        return [const ContactUsRoute()];

      case '/update_profile':
        return [const UpdateProfileRoute()];

      case '/map_nearby':
        return [const NearbyMapRoute()];
    }

    /// =========================
    /// Dynamic path handling
    /// =========================

    ///notification_details/:id
    // if (segments.length == 2 && segments.first == 'notification_details') {
    //   final id = segments[1];
    //   if (id.isEmpty) {
    //     log('[NotifNav] Missing id for notification_details');
    //     return const [];
    //   }
    //   return [NotificationDetailsRoute(id: id)];
    // }

    // /event_details/:id
    // if (segments.length == 2 && segments.first == 'event_details') {
    //   final eventId = segments[1];
    //   if (eventId.isEmpty) {
    //     log('[NotifNav] Missing eventId for event_details');
    //     return const [];
    //   }
    //   return [EventsDetailsRoute(id: eventId)];
    // }

    // /category_details/:id
    if (segments.length == 2 && segments.first == 'category_details') {
      final categoryId = segments[1];
      if (categoryId.isEmpty) return const [];
      return [CategoryDetailsRoute(categoryId: categoryId)];
    }

    // /menu/:subCategoryId/:id
    if (segments.length == 3 && segments.first == 'menu') {
      final subCategoryId = segments[1];
      final itemId = segments[2];
      if (subCategoryId.isEmpty || itemId.isEmpty) return const [];
      return [MuneRoute(secondId: subCategoryId, itemId: itemId)];
    }

    // /feedback_chat/:subCategoryId/:id
    if (segments.length == 3 && segments.first == 'feedback_chat') {
      final subCategoryId = segments[1];
      final itemId = segments[2];
      if (subCategoryId.isEmpty || itemId.isEmpty) return const [];
      return [FeedbackChatRoute(secondCategoryId: subCategoryId, itemId: itemId)];
    }

    // /claim/:subCategoryId/:id
    if (segments.length == 3 && segments.first == 'claim') {
      final subCategoryId = segments[1];
      final itemId = segments[2];
      if (subCategoryId.isEmpty || itemId.isEmpty) return const [];
      return [ClaimRoute(secondCategoryId: subCategoryId, itemId: itemId)];
    }

    // /item/:subCategoryId/:itemId
    if (segments.length == 3 && segments.first == 'item') {
      final subCategoryId = segments[1];
      final itemId = segments[2];
      if (subCategoryId.isEmpty || itemId.isEmpty) return const [];
      return [CategoryItemDetialsRoute(subCategoryId: subCategoryId, itemId: itemId)];
    }

    return const [];
  }
}
