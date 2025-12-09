// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i31;
import 'package:collection/collection.dart' as _i34;
import 'package:flutter/material.dart' as _i32;
import 'package:lawaen/features/add_to_app/presentation/views/add_event_screen.dart'
    as _i1;
import 'package:lawaen/features/add_to_app/presentation/views/add_missing_place_screen.dart'
    as _i2;
import 'package:lawaen/features/add_to_app/presentation/views/add_offer_screen.dart'
    as _i3;
import 'package:lawaen/features/add_to_app/presentation/views/add_screen.dart'
    as _i4;
import 'package:lawaen/features/add_to_app/presentation/views/claim_screen.dart'
    as _i8;
import 'package:lawaen/features/add_to_app/presentation/views/map_picker_screen.dart'
    as _i16;
import 'package:lawaen/features/add_to_app/presentation/views/mune_manager_screen.dart'
    as _i17;
import 'package:lawaen/features/add_to_app/presentation/views/services_manager_screen.dart'
    as _i29;
import 'package:lawaen/features/auth/presentation/views/login_screen.dart'
    as _i15;
import 'package:lawaen/features/auth/presentation/views/qr_code_screen.dart'
    as _i26;
import 'package:lawaen/features/auth/presentation/views/register_screen.dart'
    as _i28;
import 'package:lawaen/features/events/data/models/event_model.dart' as _i35;
import 'package:lawaen/features/events/presentation/views/events_details_screen.dart'
    as _i10;
import 'package:lawaen/features/home/data/models/category_model.dart' as _i33;
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
    as _i18;
import 'package:lawaen/features/home/presentation/views/navigation_controller.dart'
    as _i19;
import 'package:lawaen/features/home/presentation/views/notification_details_screen.dart'
    as _i21;
import 'package:lawaen/features/home/presentation/views/notification_screen.dart'
    as _i22;
import 'package:lawaen/features/nearby/presentation/views/nearby_map_screen.dart'
    as _i20;
import 'package:lawaen/features/offers/presentation/views/offers_screen.dart'
    as _i23;
import 'package:lawaen/features/onboarding/presentation/views/onboarding_screen.dart'
    as _i24;
import 'package:lawaen/features/profile/presentation/views/contact_us_screen.dart'
    as _i9;
import 'package:lawaen/features/profile/presentation/views/favorites_screen.dart'
    as _i11;
import 'package:lawaen/features/profile/presentation/views/profile_screen.dart'
    as _i25;
import 'package:lawaen/features/profile/presentation/views/ratings_screen.dart'
    as _i27;
import 'package:lawaen/features/splash/presentation/views/splash_screen.dart'
    as _i30;

/// generated route for
/// [_i1.AddEventScreen]
class AddEventRoute extends _i31.PageRouteInfo<void> {
  const AddEventRoute({List<_i31.PageRouteInfo>? children})
    : super(AddEventRoute.name, initialChildren: children);

  static const String name = 'AddEventRoute';

  static _i31.PageInfo page = _i31.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddEventScreen();
    },
  );
}

/// generated route for
/// [_i2.AddMissingPlaceScreen]
class AddMissingPlaceRoute extends _i31.PageRouteInfo<void> {
  const AddMissingPlaceRoute({List<_i31.PageRouteInfo>? children})
    : super(AddMissingPlaceRoute.name, initialChildren: children);

  static const String name = 'AddMissingPlaceRoute';

  static _i31.PageInfo page = _i31.PageInfo(
    name,
    builder: (data) {
      return const _i2.AddMissingPlaceScreen();
    },
  );
}

/// generated route for
/// [_i3.AddOfferScreen]
class AddOfferRoute extends _i31.PageRouteInfo<void> {
  const AddOfferRoute({List<_i31.PageRouteInfo>? children})
    : super(AddOfferRoute.name, initialChildren: children);

  static const String name = 'AddOfferRoute';

  static _i31.PageInfo page = _i31.PageInfo(
    name,
    builder: (data) {
      return const _i3.AddOfferScreen();
    },
  );
}

/// generated route for
/// [_i4.AddScreen]
class AddRoute extends _i31.PageRouteInfo<void> {
  const AddRoute({List<_i31.PageRouteInfo>? children})
    : super(AddRoute.name, initialChildren: children);

  static const String name = 'AddRoute';

  static _i31.PageInfo page = _i31.PageInfo(
    name,
    builder: (data) {
      return const _i4.AddScreen();
    },
  );
}

/// generated route for
/// [_i5.CategoryDetailsScreen]
class CategoryDetailsRoute
    extends _i31.PageRouteInfo<CategoryDetailsRouteArgs> {
  CategoryDetailsRoute({
    _i32.Key? key,
    String? categoryId,
    List<_i33.SecondCategory>? secondCategory,
    String? categoryName,
    List<_i31.PageRouteInfo>? children,
  }) : super(
         CategoryDetailsRoute.name,
         args: CategoryDetailsRouteArgs(
           key: key,
           categoryId: categoryId,
           secondCategory: secondCategory,
           categoryName: categoryName,
         ),
         initialChildren: children,
       );

  static const String name = 'CategoryDetailsRoute';

  static _i31.PageInfo page = _i31.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CategoryDetailsRouteArgs>(
        orElse: () => const CategoryDetailsRouteArgs(),
      );
      return _i5.CategoryDetailsScreen(
        key: args.key,
        categoryId: args.categoryId,
        secondCategory: args.secondCategory,
        categoryName: args.categoryName,
      );
    },
  );
}

class CategoryDetailsRouteArgs {
  const CategoryDetailsRouteArgs({
    this.key,
    this.categoryId,
    this.secondCategory,
    this.categoryName,
  });

  final _i32.Key? key;

  final String? categoryId;

  final List<_i33.SecondCategory>? secondCategory;

  final String? categoryName;

  @override
  String toString() {
    return 'CategoryDetailsRouteArgs{key: $key, categoryId: $categoryId, secondCategory: $secondCategory, categoryName: $categoryName}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CategoryDetailsRouteArgs) return false;
    return key == other.key &&
        categoryId == other.categoryId &&
        const _i34.ListEquality<_i33.SecondCategory>().equals(
          secondCategory,
          other.secondCategory,
        ) &&
        categoryName == other.categoryName;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      categoryId.hashCode ^
      const _i34.ListEquality<_i33.SecondCategory>().hash(secondCategory) ^
      categoryName.hashCode;
}

/// generated route for
/// [_i6.CategoryItemDetialsScreen]
class CategoryItemDetialsRoute
    extends _i31.PageRouteInfo<CategoryItemDetialsRouteArgs> {
  CategoryItemDetialsRoute({
    _i32.Key? key,
    required String subCategoryId,
    required String itemId,
    List<_i31.PageRouteInfo>? children,
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

  static _i31.PageInfo page = _i31.PageInfo(
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

  final _i32.Key? key;

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
class CategoryRoute extends _i31.PageRouteInfo<CategoryRouteArgs> {
  CategoryRoute({
    _i32.Key? key,
    required List<_i33.CategoryModel> categories,
    List<_i31.PageRouteInfo>? children,
  }) : super(
         CategoryRoute.name,
         args: CategoryRouteArgs(key: key, categories: categories),
         initialChildren: children,
       );

  static const String name = 'CategoryRoute';

  static _i31.PageInfo page = _i31.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CategoryRouteArgs>();
      return _i7.CategoryScreen(key: args.key, categories: args.categories);
    },
  );
}

class CategoryRouteArgs {
  const CategoryRouteArgs({this.key, required this.categories});

  final _i32.Key? key;

  final List<_i33.CategoryModel> categories;

  @override
  String toString() {
    return 'CategoryRouteArgs{key: $key, categories: $categories}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CategoryRouteArgs) return false;
    return key == other.key &&
        const _i34.ListEquality<_i33.CategoryModel>().equals(
          categories,
          other.categories,
        );
  }

  @override
  int get hashCode =>
      key.hashCode ^
      const _i34.ListEquality<_i33.CategoryModel>().hash(categories);
}

/// generated route for
/// [_i8.ClaimScreen]
class ClaimRoute extends _i31.PageRouteInfo<void> {
  const ClaimRoute({List<_i31.PageRouteInfo>? children})
    : super(ClaimRoute.name, initialChildren: children);

  static const String name = 'ClaimRoute';

  static _i31.PageInfo page = _i31.PageInfo(
    name,
    builder: (data) {
      return const _i8.ClaimScreen();
    },
  );
}

/// generated route for
/// [_i9.ContactUsScreen]
class ContactUsRoute extends _i31.PageRouteInfo<void> {
  const ContactUsRoute({List<_i31.PageRouteInfo>? children})
    : super(ContactUsRoute.name, initialChildren: children);

  static const String name = 'ContactUsRoute';

  static _i31.PageInfo page = _i31.PageInfo(
    name,
    builder: (data) {
      return const _i9.ContactUsScreen();
    },
  );
}

/// generated route for
/// [_i10.EventsDetailsScreen]
class EventsDetailsRoute extends _i31.PageRouteInfo<EventsDetailsRouteArgs> {
  EventsDetailsRoute({
    _i32.Key? key,
    required _i35.EventModel event,
    String? address,
    List<_i31.PageRouteInfo>? children,
  }) : super(
         EventsDetailsRoute.name,
         args: EventsDetailsRouteArgs(key: key, event: event, address: address),
         initialChildren: children,
       );

  static const String name = 'EventsDetailsRoute';

  static _i31.PageInfo page = _i31.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EventsDetailsRouteArgs>();
      return _i10.EventsDetailsScreen(
        key: args.key,
        event: args.event,
        address: args.address,
      );
    },
  );
}

class EventsDetailsRouteArgs {
  const EventsDetailsRouteArgs({this.key, required this.event, this.address});

  final _i32.Key? key;

  final _i35.EventModel event;

  final String? address;

  @override
  String toString() {
    return 'EventsDetailsRouteArgs{key: $key, event: $event, address: $address}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EventsDetailsRouteArgs) return false;
    return key == other.key && event == other.event && address == other.address;
  }

  @override
  int get hashCode => key.hashCode ^ event.hashCode ^ address.hashCode;
}

/// generated route for
/// [_i11.FavoritesScreen]
class FavoritesRoute extends _i31.PageRouteInfo<void> {
  const FavoritesRoute({List<_i31.PageRouteInfo>? children})
    : super(FavoritesRoute.name, initialChildren: children);

  static const String name = 'FavoritesRoute';

  static _i31.PageInfo page = _i31.PageInfo(
    name,
    builder: (data) {
      return const _i11.FavoritesScreen();
    },
  );
}

/// generated route for
/// [_i12.FeedbackChatScreen]
class FeedbackChatRoute extends _i31.PageRouteInfo<void> {
  const FeedbackChatRoute({List<_i31.PageRouteInfo>? children})
    : super(FeedbackChatRoute.name, initialChildren: children);

  static const String name = 'FeedbackChatRoute';

  static _i31.PageInfo page = _i31.PageInfo(
    name,
    builder: (data) {
      return const _i12.FeedbackChatScreen();
    },
  );
}

/// generated route for
/// [_i13.FeedbackScreen]
class FeedbackRoute extends _i31.PageRouteInfo<void> {
  const FeedbackRoute({List<_i31.PageRouteInfo>? children})
    : super(FeedbackRoute.name, initialChildren: children);

  static const String name = 'FeedbackRoute';

  static _i31.PageInfo page = _i31.PageInfo(
    name,
    builder: (data) {
      return const _i13.FeedbackScreen();
    },
  );
}

/// generated route for
/// [_i14.HomeScreen]
class HomeRoute extends _i31.PageRouteInfo<void> {
  const HomeRoute({List<_i31.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i31.PageInfo page = _i31.PageInfo(
    name,
    builder: (data) {
      return const _i14.HomeScreen();
    },
  );
}

/// generated route for
/// [_i15.LoginScreen]
class LoginRoute extends _i31.PageRouteInfo<void> {
  const LoginRoute({List<_i31.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i31.PageInfo page = _i31.PageInfo(
    name,
    builder: (data) {
      return const _i15.LoginScreen();
    },
  );
}

/// generated route for
/// [_i16.MapPickerScreen]
class MapPickerRoute extends _i31.PageRouteInfo<MapPickerRouteArgs> {
  MapPickerRoute({
    _i32.Key? key,
    double? initialLatitude,
    double? initialLongitude,
    List<_i31.PageRouteInfo>? children,
  }) : super(
         MapPickerRoute.name,
         args: MapPickerRouteArgs(
           key: key,
           initialLatitude: initialLatitude,
           initialLongitude: initialLongitude,
         ),
         initialChildren: children,
       );

  static const String name = 'MapPickerRoute';

  static _i31.PageInfo page = _i31.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MapPickerRouteArgs>(
        orElse: () => const MapPickerRouteArgs(),
      );
      return _i16.MapPickerScreen(
        key: args.key,
        initialLatitude: args.initialLatitude,
        initialLongitude: args.initialLongitude,
      );
    },
  );
}

class MapPickerRouteArgs {
  const MapPickerRouteArgs({
    this.key,
    this.initialLatitude,
    this.initialLongitude,
  });

  final _i32.Key? key;

  final double? initialLatitude;

  final double? initialLongitude;

  @override
  String toString() {
    return 'MapPickerRouteArgs{key: $key, initialLatitude: $initialLatitude, initialLongitude: $initialLongitude}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MapPickerRouteArgs) return false;
    return key == other.key &&
        initialLatitude == other.initialLatitude &&
        initialLongitude == other.initialLongitude;
  }

  @override
  int get hashCode =>
      key.hashCode ^ initialLatitude.hashCode ^ initialLongitude.hashCode;
}

/// generated route for
/// [_i17.MuneManagerScreen]
class MuneManagerRoute extends _i31.PageRouteInfo<void> {
  const MuneManagerRoute({List<_i31.PageRouteInfo>? children})
    : super(MuneManagerRoute.name, initialChildren: children);

  static const String name = 'MuneManagerRoute';

  static _i31.PageInfo page = _i31.PageInfo(
    name,
    builder: (data) {
      return const _i17.MuneManagerScreen();
    },
  );
}

/// generated route for
/// [_i18.MuneScreen]
class MuneRoute extends _i31.PageRouteInfo<void> {
  const MuneRoute({List<_i31.PageRouteInfo>? children})
    : super(MuneRoute.name, initialChildren: children);

  static const String name = 'MuneRoute';

  static _i31.PageInfo page = _i31.PageInfo(
    name,
    builder: (data) {
      return const _i18.MuneScreen();
    },
  );
}

/// generated route for
/// [_i19.NavigationControllerScreen]
class NavigationControllerRoute
    extends _i31.PageRouteInfo<NavigationControllerRouteArgs> {
  NavigationControllerRoute({
    _i32.Key? key,
    int initialIndex = 0,
    List<_i31.PageRouteInfo>? children,
  }) : super(
         NavigationControllerRoute.name,
         args: NavigationControllerRouteArgs(
           key: key,
           initialIndex: initialIndex,
         ),
         initialChildren: children,
       );

  static const String name = 'NavigationControllerRoute';

  static _i31.PageInfo page = _i31.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NavigationControllerRouteArgs>(
        orElse: () => const NavigationControllerRouteArgs(),
      );
      return _i19.NavigationControllerScreen(
        key: args.key,
        initialIndex: args.initialIndex,
      );
    },
  );
}

class NavigationControllerRouteArgs {
  const NavigationControllerRouteArgs({this.key, this.initialIndex = 0});

  final _i32.Key? key;

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
/// [_i20.NearbyMapScreen]
class NearbyMapRoute extends _i31.PageRouteInfo<void> {
  const NearbyMapRoute({List<_i31.PageRouteInfo>? children})
    : super(NearbyMapRoute.name, initialChildren: children);

  static const String name = 'NearbyMapRoute';

  static _i31.PageInfo page = _i31.PageInfo(
    name,
    builder: (data) {
      return const _i20.NearbyMapScreen();
    },
  );
}

/// generated route for
/// [_i21.NotificationDetailsScreen]
class NotificationDetailsRoute extends _i31.PageRouteInfo<void> {
  const NotificationDetailsRoute({List<_i31.PageRouteInfo>? children})
    : super(NotificationDetailsRoute.name, initialChildren: children);

  static const String name = 'NotificationDetailsRoute';

  static _i31.PageInfo page = _i31.PageInfo(
    name,
    builder: (data) {
      return const _i21.NotificationDetailsScreen();
    },
  );
}

/// generated route for
/// [_i22.NotificationScreen]
class NotificationRoute extends _i31.PageRouteInfo<void> {
  const NotificationRoute({List<_i31.PageRouteInfo>? children})
    : super(NotificationRoute.name, initialChildren: children);

  static const String name = 'NotificationRoute';

  static _i31.PageInfo page = _i31.PageInfo(
    name,
    builder: (data) {
      return const _i22.NotificationScreen();
    },
  );
}

/// generated route for
/// [_i23.OffersScreen]
class OffersRoute extends _i31.PageRouteInfo<void> {
  const OffersRoute({List<_i31.PageRouteInfo>? children})
    : super(OffersRoute.name, initialChildren: children);

  static const String name = 'OffersRoute';

  static _i31.PageInfo page = _i31.PageInfo(
    name,
    builder: (data) {
      return const _i23.OffersScreen();
    },
  );
}

/// generated route for
/// [_i24.OnboardingScreen]
class OnboardingRoute extends _i31.PageRouteInfo<void> {
  const OnboardingRoute({List<_i31.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i31.PageInfo page = _i31.PageInfo(
    name,
    builder: (data) {
      return const _i24.OnboardingScreen();
    },
  );
}

/// generated route for
/// [_i25.ProfileScreen]
class ProfileRoute extends _i31.PageRouteInfo<void> {
  const ProfileRoute({List<_i31.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i31.PageInfo page = _i31.PageInfo(
    name,
    builder: (data) {
      return const _i25.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i26.QrCodeScreen]
class QrCodeRoute extends _i31.PageRouteInfo<void> {
  const QrCodeRoute({List<_i31.PageRouteInfo>? children})
    : super(QrCodeRoute.name, initialChildren: children);

  static const String name = 'QrCodeRoute';

  static _i31.PageInfo page = _i31.PageInfo(
    name,
    builder: (data) {
      return const _i26.QrCodeScreen();
    },
  );
}

/// generated route for
/// [_i27.RatingsScreen]
class RatingsRoute extends _i31.PageRouteInfo<void> {
  const RatingsRoute({List<_i31.PageRouteInfo>? children})
    : super(RatingsRoute.name, initialChildren: children);

  static const String name = 'RatingsRoute';

  static _i31.PageInfo page = _i31.PageInfo(
    name,
    builder: (data) {
      return const _i27.RatingsScreen();
    },
  );
}

/// generated route for
/// [_i28.RegisterScreen]
class RegisterRoute extends _i31.PageRouteInfo<void> {
  const RegisterRoute({List<_i31.PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static _i31.PageInfo page = _i31.PageInfo(
    name,
    builder: (data) {
      return const _i28.RegisterScreen();
    },
  );
}

/// generated route for
/// [_i29.ServicesManagerScreen]
class ServicesManagerRoute extends _i31.PageRouteInfo<void> {
  const ServicesManagerRoute({List<_i31.PageRouteInfo>? children})
    : super(ServicesManagerRoute.name, initialChildren: children);

  static const String name = 'ServicesManagerRoute';

  static _i31.PageInfo page = _i31.PageInfo(
    name,
    builder: (data) {
      return const _i29.ServicesManagerScreen();
    },
  );
}

/// generated route for
/// [_i30.SplashScreen]
class SplashRoute extends _i31.PageRouteInfo<void> {
  const SplashRoute({List<_i31.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i31.PageInfo page = _i31.PageInfo(
    name,
    builder: (data) {
      return const _i30.SplashScreen();
    },
  );
}
