// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i29;
import 'package:flutter/material.dart' as _i30;
import 'package:lawaen/features/add_to_app/presentation/views/add_classified_screen.dart'
    as _i1;
import 'package:lawaen/features/add_to_app/presentation/views/add_event_screen.dart'
    as _i2;
import 'package:lawaen/features/add_to_app/presentation/views/add_missing_place_screen.dart'
    as _i3;
import 'package:lawaen/features/add_to_app/presentation/views/add_screen.dart'
    as _i4;
import 'package:lawaen/features/add_to_app/presentation/views/claim_screen.dart'
    as _i8;
import 'package:lawaen/features/add_to_app/presentation/views/mune_manager_screen.dart'
    as _i16;
import 'package:lawaen/features/add_to_app/presentation/views/services_manager_screen.dart'
    as _i27;
import 'package:lawaen/features/auth/presentation/views/login_screen.dart'
    as _i15;
import 'package:lawaen/features/auth/presentation/views/qr_code_screen.dart'
    as _i24;
import 'package:lawaen/features/auth/presentation/views/register_screen.dart'
    as _i26;
import 'package:lawaen/features/events/presentation/views/events_details_screen.dart'
    as _i10;
import 'package:lawaen/features/home/presentation/views/category_details_screen.dart'
    as _i5;
import 'package:lawaen/features/home/presentation/views/category_item_detials_screen.dart'
    as _i6;
import 'package:lawaen/features/home/presentation/views/category_screen.dart'
    as _i7;
import 'package:lawaen/features/home/presentation/views/feedback_chat_screen.dart'
    as _i12;
import 'package:lawaen/features/home/presentation/views/feedback_screen.dart'
    as _i13;
import 'package:lawaen/features/home/presentation/views/home_screen.dart'
    as _i14;
import 'package:lawaen/features/home/presentation/views/mune_screen.dart'
    as _i17;
import 'package:lawaen/features/home/presentation/views/navigation_controller.dart'
    as _i18;
import 'package:lawaen/features/home/presentation/views/notification_details_screen.dart'
    as _i19;
import 'package:lawaen/features/home/presentation/views/notification_screen.dart'
    as _i20;
import 'package:lawaen/features/offers/presentation/views/offers_screen.dart'
    as _i21;
import 'package:lawaen/features/onboarding/presentation/views/onboarding_screen.dart'
    as _i22;
import 'package:lawaen/features/profile/presentation/views/contact_us_screen.dart'
    as _i9;
import 'package:lawaen/features/profile/presentation/views/favorites_screen.dart'
    as _i11;
import 'package:lawaen/features/profile/presentation/views/profile_screen.dart'
    as _i23;
import 'package:lawaen/features/profile/presentation/views/ratings_screen.dart'
    as _i25;
import 'package:lawaen/features/splash/presentation/views/splash_screen.dart'
    as _i28;

/// generated route for
/// [_i1.AddClassifiedScreen]
class AddClassifiedRoute extends _i29.PageRouteInfo<void> {
  const AddClassifiedRoute({List<_i29.PageRouteInfo>? children})
    : super(AddClassifiedRoute.name, initialChildren: children);

  static const String name = 'AddClassifiedRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddClassifiedScreen();
    },
  );
}

/// generated route for
/// [_i2.AddEventScreen]
class AddEventRoute extends _i29.PageRouteInfo<void> {
  const AddEventRoute({List<_i29.PageRouteInfo>? children})
    : super(AddEventRoute.name, initialChildren: children);

  static const String name = 'AddEventRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i2.AddEventScreen();
    },
  );
}

/// generated route for
/// [_i3.AddMissingPlaceScreen]
class AddMissingPlaceRoute extends _i29.PageRouteInfo<void> {
  const AddMissingPlaceRoute({List<_i29.PageRouteInfo>? children})
    : super(AddMissingPlaceRoute.name, initialChildren: children);

  static const String name = 'AddMissingPlaceRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i3.AddMissingPlaceScreen();
    },
  );
}

/// generated route for
/// [_i4.AddScreen]
class AddRoute extends _i29.PageRouteInfo<void> {
  const AddRoute({List<_i29.PageRouteInfo>? children})
    : super(AddRoute.name, initialChildren: children);

  static const String name = 'AddRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i4.AddScreen();
    },
  );
}

/// generated route for
/// [_i5.CategoryDetailsScreen]
class CategoryDetailsRoute extends _i29.PageRouteInfo<void> {
  const CategoryDetailsRoute({List<_i29.PageRouteInfo>? children})
    : super(CategoryDetailsRoute.name, initialChildren: children);

  static const String name = 'CategoryDetailsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i5.CategoryDetailsScreen();
    },
  );
}

/// generated route for
/// [_i6.CategoryItemDetialsScreen]
class CategoryItemDetialsRoute
    extends _i29.PageRouteInfo<CategoryItemDetialsRouteArgs> {
  CategoryItemDetialsRoute({
    _i30.Key? key,
    required String subCategoryId,
    required String itemId,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         CategoryItemDetialsRoute.name,
         args: CategoryItemDetialsRouteArgs(
           key: key,
           subCategoryId: subCategoryId,
           itemId: itemId,
         ),
         rawPathParams: {'subCategoryId': subCategoryId, 'itemId': itemId},
         initialChildren: children,
       );

  static const String name = 'CategoryItemDetialsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<CategoryItemDetialsRouteArgs>(
        orElse: () => CategoryItemDetialsRouteArgs(
          subCategoryId: pathParams.getString('subCategoryId'),
          itemId: pathParams.getString('itemId'),
        ),
      );
      return _i6.CategoryItemDetialsScreen(
        key: args.key,
        subCategoryId: args.subCategoryId,
        itemId: args.itemId,
      );
    },
  );
}

class CategoryItemDetialsRouteArgs {
  const CategoryItemDetialsRouteArgs({
    this.key,
    required this.subCategoryId,
    required this.itemId,
  });

  final _i30.Key? key;

  final String subCategoryId;

  final String itemId;

  @override
  String toString() {
    return 'CategoryItemDetialsRouteArgs{key: $key, subCategoryId: $subCategoryId, itemId: $itemId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CategoryItemDetialsRouteArgs) return false;
    return key == other.key &&
        subCategoryId == other.subCategoryId &&
        itemId == other.itemId;
  }

  @override
  int get hashCode => key.hashCode ^ subCategoryId.hashCode ^ itemId.hashCode;
}

/// generated route for
/// [_i7.CategoryScreen]
class CategoryRoute extends _i29.PageRouteInfo<void> {
  const CategoryRoute({List<_i29.PageRouteInfo>? children})
    : super(CategoryRoute.name, initialChildren: children);

  static const String name = 'CategoryRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i7.CategoryScreen();
    },
  );
}

/// generated route for
/// [_i8.ClaimScreen]
class ClaimRoute extends _i29.PageRouteInfo<void> {
  const ClaimRoute({List<_i29.PageRouteInfo>? children})
    : super(ClaimRoute.name, initialChildren: children);

  static const String name = 'ClaimRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i8.ClaimScreen();
    },
  );
}

/// generated route for
/// [_i9.ContactUsScreen]
class ContactUsRoute extends _i29.PageRouteInfo<void> {
  const ContactUsRoute({List<_i29.PageRouteInfo>? children})
    : super(ContactUsRoute.name, initialChildren: children);

  static const String name = 'ContactUsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i9.ContactUsScreen();
    },
  );
}

/// generated route for
/// [_i10.EventsDetailsScreen]
class EventsDetailsRoute extends _i29.PageRouteInfo<void> {
  const EventsDetailsRoute({List<_i29.PageRouteInfo>? children})
    : super(EventsDetailsRoute.name, initialChildren: children);

  static const String name = 'EventsDetailsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i10.EventsDetailsScreen();
    },
  );
}

/// generated route for
/// [_i11.FavoritesScreen]
class FavoritesRoute extends _i29.PageRouteInfo<void> {
  const FavoritesRoute({List<_i29.PageRouteInfo>? children})
    : super(FavoritesRoute.name, initialChildren: children);

  static const String name = 'FavoritesRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i11.FavoritesScreen();
    },
  );
}

/// generated route for
/// [_i12.FeedbackChatScreen]
class FeedbackChatRoute extends _i29.PageRouteInfo<void> {
  const FeedbackChatRoute({List<_i29.PageRouteInfo>? children})
    : super(FeedbackChatRoute.name, initialChildren: children);

  static const String name = 'FeedbackChatRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i12.FeedbackChatScreen();
    },
  );
}

/// generated route for
/// [_i13.FeedbackScreen]
class FeedbackRoute extends _i29.PageRouteInfo<void> {
  const FeedbackRoute({List<_i29.PageRouteInfo>? children})
    : super(FeedbackRoute.name, initialChildren: children);

  static const String name = 'FeedbackRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i13.FeedbackScreen();
    },
  );
}

/// generated route for
/// [_i14.HomeScreen]
class HomeRoute extends _i29.PageRouteInfo<void> {
  const HomeRoute({List<_i29.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i14.HomeScreen();
    },
  );
}

/// generated route for
/// [_i15.LoginScreen]
class LoginRoute extends _i29.PageRouteInfo<void> {
  const LoginRoute({List<_i29.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i15.LoginScreen();
    },
  );
}

/// generated route for
/// [_i16.MuneManagerScreen]
class MuneManagerRoute extends _i29.PageRouteInfo<void> {
  const MuneManagerRoute({List<_i29.PageRouteInfo>? children})
    : super(MuneManagerRoute.name, initialChildren: children);

  static const String name = 'MuneManagerRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i16.MuneManagerScreen();
    },
  );
}

/// generated route for
/// [_i17.MuneScreen]
class MuneRoute extends _i29.PageRouteInfo<void> {
  const MuneRoute({List<_i29.PageRouteInfo>? children})
    : super(MuneRoute.name, initialChildren: children);

  static const String name = 'MuneRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i17.MuneScreen();
    },
  );
}

/// generated route for
/// [_i18.NavigationControllerScreen]
class NavigationControllerRoute
    extends _i29.PageRouteInfo<NavigationControllerRouteArgs> {
  NavigationControllerRoute({
    _i30.Key? key,
    int initialIndex = 0,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         NavigationControllerRoute.name,
         args: NavigationControllerRouteArgs(
           key: key,
           initialIndex: initialIndex,
         ),
         initialChildren: children,
       );

  static const String name = 'NavigationControllerRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NavigationControllerRouteArgs>(
        orElse: () => const NavigationControllerRouteArgs(),
      );
      return _i18.NavigationControllerScreen(
        key: args.key,
        initialIndex: args.initialIndex,
      );
    },
  );
}

class NavigationControllerRouteArgs {
  const NavigationControllerRouteArgs({this.key, this.initialIndex = 0});

  final _i30.Key? key;

  final int initialIndex;

  @override
  String toString() {
    return 'NavigationControllerRouteArgs{key: $key, initialIndex: $initialIndex}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NavigationControllerRouteArgs) return false;
    return key == other.key && initialIndex == other.initialIndex;
  }

  @override
  int get hashCode => key.hashCode ^ initialIndex.hashCode;
}

/// generated route for
/// [_i19.NotificationDetailsScreen]
class NotificationDetailsRoute extends _i29.PageRouteInfo<void> {
  const NotificationDetailsRoute({List<_i29.PageRouteInfo>? children})
    : super(NotificationDetailsRoute.name, initialChildren: children);

  static const String name = 'NotificationDetailsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i19.NotificationDetailsScreen();
    },
  );
}

/// generated route for
/// [_i20.NotificationScreen]
class NotificationRoute extends _i29.PageRouteInfo<void> {
  const NotificationRoute({List<_i29.PageRouteInfo>? children})
    : super(NotificationRoute.name, initialChildren: children);

  static const String name = 'NotificationRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i20.NotificationScreen();
    },
  );
}

/// generated route for
/// [_i21.OffersScreen]
class OffersRoute extends _i29.PageRouteInfo<OffersRouteArgs> {
  OffersRoute({_i30.Key? key, List<_i29.PageRouteInfo>? children})
    : super(
        OffersRoute.name,
        args: OffersRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'OffersRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OffersRouteArgs>(
        orElse: () => const OffersRouteArgs(),
      );
      return _i21.OffersScreen(key: args.key);
    },
  );
}

class OffersRouteArgs {
  const OffersRouteArgs({this.key});

  final _i30.Key? key;

  @override
  String toString() {
    return 'OffersRouteArgs{key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! OffersRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [_i22.OnboardingScreen]
class OnboardingRoute extends _i29.PageRouteInfo<void> {
  const OnboardingRoute({List<_i29.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i22.OnboardingScreen();
    },
  );
}

/// generated route for
/// [_i23.ProfileScreen]
class ProfileRoute extends _i29.PageRouteInfo<void> {
  const ProfileRoute({List<_i29.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i23.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i24.QrCodeScreen]
class QrCodeRoute extends _i29.PageRouteInfo<void> {
  const QrCodeRoute({List<_i29.PageRouteInfo>? children})
    : super(QrCodeRoute.name, initialChildren: children);

  static const String name = 'QrCodeRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i24.QrCodeScreen();
    },
  );
}

/// generated route for
/// [_i25.RatingsScreen]
class RatingsRoute extends _i29.PageRouteInfo<void> {
  const RatingsRoute({List<_i29.PageRouteInfo>? children})
    : super(RatingsRoute.name, initialChildren: children);

  static const String name = 'RatingsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i25.RatingsScreen();
    },
  );
}

/// generated route for
/// [_i26.RegisterScreen]
class RegisterRoute extends _i29.PageRouteInfo<void> {
  const RegisterRoute({List<_i29.PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i26.RegisterScreen();
    },
  );
}

/// generated route for
/// [_i27.ServicesManagerScreen]
class ServicesManagerRoute extends _i29.PageRouteInfo<void> {
  const ServicesManagerRoute({List<_i29.PageRouteInfo>? children})
    : super(ServicesManagerRoute.name, initialChildren: children);

  static const String name = 'ServicesManagerRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i27.ServicesManagerScreen();
    },
  );
}

/// generated route for
/// [_i28.SplashScreen]
class SplashRoute extends _i29.PageRouteInfo<void> {
  const SplashRoute({List<_i29.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i28.SplashScreen();
    },
  );
}
