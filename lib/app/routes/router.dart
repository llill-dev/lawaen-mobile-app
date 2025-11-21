import 'package:auto_route/auto_route.dart';

import 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),

    // Home
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: NavigationControllerRoute.page),
    AutoRoute(page: NotificationRoute.page),
    AutoRoute(page: NotificationDetailsRoute.page),
    AutoRoute(page: CategoryRoute.page),
    AutoRoute(page: CategoryDetailsRoute.page),
    AutoRoute(page: CategoryItemDetialsRoute.page),
    AutoRoute(page: MuneRoute.page),
    AutoRoute(page: FeedbackRoute.page),
    AutoRoute(page: FeedbackChatRoute.page),

    // Add
    AutoRoute(page: AddRoute.page),
    AutoRoute(page: AddEventRoute.page),
    AutoRoute(page: AddClassifiedRoute.page),
    AutoRoute(page: AddMissingPlaceRoute.page),
    AutoRoute(page: ServicesManagerRoute.page),
    AutoRoute(page: MuneManagerRoute.page),
    AutoRoute(page: ClaimRoute.page),

    // Events
    AutoRoute(page: EventsDetailsRoute.page),

    // Onboarding
    AutoRoute(page: OnboardingRoute.page),

    // Auth
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(page: QrCodeRoute.page),

    // Profile
    AutoRoute(page: ProfileRoute.page),
    AutoRoute(page: RatingsRoute.page),
  ];
}
