// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i33;
import 'package:collection/collection.dart' as _i36;
import 'package:flutter/material.dart' as _i34;
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
    as _i30;
import 'package:lawaen/features/auth/presentation/views/login_screen.dart'
    as _i15;
import 'package:lawaen/features/auth/presentation/views/qr_code_screen.dart'
    as _i27;
import 'package:lawaen/features/auth/presentation/views/register_screen.dart'
    as _i29;
import 'package:lawaen/features/events/data/models/event_model.dart' as _i37;
import 'package:lawaen/features/events/presentation/views/events_details_screen.dart'
    as _i10;
import 'package:lawaen/features/home/data/models/category_model.dart' as _i35;
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
import 'package:lawaen/features/profile/presentation/views/profile_static_screen.dart'
    as _i26;
import 'package:lawaen/features/profile/presentation/views/ratings_screen.dart'
    as _i28;
import 'package:lawaen/features/profile/presentation/views/update_profile_screen.dart'
    as _i32;
import 'package:lawaen/features/splash/presentation/views/splash_screen.dart'
    as _i31;

/// generated route for
/// [_i1.AddEventScreen]
class AddEventRoute extends _i33.PageRouteInfo<void> {
  const AddEventRoute({List<_i33.PageRouteInfo>? children})
    : super(AddEventRoute.name, initialChildren: children);

  static const String name = 'AddEventRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddEventScreen();
    },
  );
}

/// generated route for
/// [_i2.AddMissingPlaceScreen]
class AddMissingPlaceRoute extends _i33.PageRouteInfo<void> {
  const AddMissingPlaceRoute({List<_i33.PageRouteInfo>? children})
    : super(AddMissingPlaceRoute.name, initialChildren: children);

  static const String name = 'AddMissingPlaceRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i2.AddMissingPlaceScreen();
    },
  );
}

/// generated route for
/// [_i3.AddOfferScreen]
class AddOfferRoute extends _i33.PageRouteInfo<void> {
  const AddOfferRoute({List<_i33.PageRouteInfo>? children})
    : super(AddOfferRoute.name, initialChildren: children);

  static const String name = 'AddOfferRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i3.AddOfferScreen();
    },
  );
}

/// generated route for
/// [_i4.AddScreen]
class AddRoute extends _i33.PageRouteInfo<void> {
  const AddRoute({List<_i33.PageRouteInfo>? children})
    : super(AddRoute.name, initialChildren: children);

  static const String name = 'AddRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i4.AddScreen();
    },
  );
}

/// generated route for
/// [_i5.CategoryDetailsScreen]
class CategoryDetailsRoute
    extends _i33.PageRouteInfo<CategoryDetailsRouteArgs> {
  CategoryDetailsRoute({
    _i34.Key? key,
    String? categoryId,
    List<_i35.SecondCategory>? secondCategory,
    String? categoryName,
    List<_i33.PageRouteInfo>? children,
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

  static _i33.PageInfo page = _i33.PageInfo(
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

  final _i34.Key? key;

  final String? categoryId;

  final List<_i35.SecondCategory>? secondCategory;

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
        const _i36.ListEquality<_i35.SecondCategory>().equals(
          secondCategory,
          other.secondCategory,
        ) &&
        categoryName == other.categoryName;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      categoryId.hashCode ^
      const _i36.ListEquality<_i35.SecondCategory>().hash(secondCategory) ^
      categoryName.hashCode;
}

/// generated route for
/// [_i6.CategoryItemDetialsScreen]
class CategoryItemDetialsRoute
    extends _i33.PageRouteInfo<CategoryItemDetialsRouteArgs> {
  CategoryItemDetialsRoute({
    _i34.Key? key,
    required String subCategoryId,
    required String itemId,
    List<_i33.PageRouteInfo>? children,
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

  static _i33.PageInfo page = _i33.PageInfo(
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

  final _i34.Key? key;

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
class CategoryRoute extends _i33.PageRouteInfo<CategoryRouteArgs> {
  CategoryRoute({
    _i34.Key? key,
    required List<_i35.CategoryModel> categories,
    List<_i33.PageRouteInfo>? children,
  }) : super(
         CategoryRoute.name,
         args: CategoryRouteArgs(key: key, categories: categories),
         initialChildren: children,
       );

  static const String name = 'CategoryRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CategoryRouteArgs>();
      return _i7.CategoryScreen(key: args.key, categories: args.categories);
    },
  );
}

class CategoryRouteArgs {
  const CategoryRouteArgs({this.key, required this.categories});

  final _i34.Key? key;

  final List<_i35.CategoryModel> categories;

  @override
  String toString() {
    return 'CategoryRouteArgs{key: $key, categories: $categories}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CategoryRouteArgs) return false;
    return key == other.key &&
        const _i36.ListEquality<_i35.CategoryModel>().equals(
          categories,
          other.categories,
        );
  }

  @override
  int get hashCode =>
      key.hashCode ^
      const _i36.ListEquality<_i35.CategoryModel>().hash(categories);
}

/// generated route for
/// [_i8.ClaimScreen]
class ClaimRoute extends _i33.PageRouteInfo<ClaimRouteArgs> {
  ClaimRoute({
    _i34.Key? key,
    required String itemId,
    required String secondCategoryId,
    List<_i33.PageRouteInfo>? children,
  }) : super(
         ClaimRoute.name,
         args: ClaimRouteArgs(
           key: key,
           itemId: itemId,
           secondCategoryId: secondCategoryId,
         ),
         initialChildren: children,
       );

  static const String name = 'ClaimRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ClaimRouteArgs>();
      return _i8.ClaimScreen(
        key: args.key,
        itemId: args.itemId,
        secondCategoryId: args.secondCategoryId,
      );
    },
  );
}

class ClaimRouteArgs {
  const ClaimRouteArgs({
    this.key,
    required this.itemId,
    required this.secondCategoryId,
  });

  final _i34.Key? key;

  final String itemId;

  final String secondCategoryId;

  @override
  String toString() {
    return 'ClaimRouteArgs{key: $key, itemId: $itemId, secondCategoryId: $secondCategoryId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ClaimRouteArgs) return false;
    return key == other.key &&
        itemId == other.itemId &&
        secondCategoryId == other.secondCategoryId;
  }

  @override
  int get hashCode =>
      key.hashCode ^ itemId.hashCode ^ secondCategoryId.hashCode;
}

/// generated route for
/// [_i9.ContactUsScreen]
class ContactUsRoute extends _i33.PageRouteInfo<void> {
  const ContactUsRoute({List<_i33.PageRouteInfo>? children})
    : super(ContactUsRoute.name, initialChildren: children);

  static const String name = 'ContactUsRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i9.ContactUsScreen();
    },
  );
}

/// generated route for
/// [_i10.EventsDetailsScreen]
class EventsDetailsRoute extends _i33.PageRouteInfo<EventsDetailsRouteArgs> {
  EventsDetailsRoute({
    _i34.Key? key,
    required _i37.EventModel event,
    String? address,
    List<_i33.PageRouteInfo>? children,
  }) : super(
         EventsDetailsRoute.name,
         args: EventsDetailsRouteArgs(key: key, event: event, address: address),
         initialChildren: children,
       );

  static const String name = 'EventsDetailsRoute';

  static _i33.PageInfo page = _i33.PageInfo(
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

  final _i34.Key? key;

  final _i37.EventModel event;

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
class FavoritesRoute extends _i33.PageRouteInfo<void> {
  const FavoritesRoute({List<_i33.PageRouteInfo>? children})
    : super(FavoritesRoute.name, initialChildren: children);

  static const String name = 'FavoritesRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i11.FavoritesScreen();
    },
  );
}

/// generated route for
/// [_i12.FeedbackChatScreen]
class FeedbackChatRoute extends _i33.PageRouteInfo<FeedbackChatRouteArgs> {
  FeedbackChatRoute({
    _i34.Key? key,
    required String itemId,
    required String secondCategoryId,
    List<_i33.PageRouteInfo>? children,
  }) : super(
         FeedbackChatRoute.name,
         args: FeedbackChatRouteArgs(
           key: key,
           itemId: itemId,
           secondCategoryId: secondCategoryId,
         ),
         initialChildren: children,
       );

  static const String name = 'FeedbackChatRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FeedbackChatRouteArgs>();
      return _i12.FeedbackChatScreen(
        key: args.key,
        itemId: args.itemId,
        secondCategoryId: args.secondCategoryId,
      );
    },
  );
}

class FeedbackChatRouteArgs {
  const FeedbackChatRouteArgs({
    this.key,
    required this.itemId,
    required this.secondCategoryId,
  });

  final _i34.Key? key;

  final String itemId;

  final String secondCategoryId;

  @override
  String toString() {
    return 'FeedbackChatRouteArgs{key: $key, itemId: $itemId, secondCategoryId: $secondCategoryId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! FeedbackChatRouteArgs) return false;
    return key == other.key &&
        itemId == other.itemId &&
        secondCategoryId == other.secondCategoryId;
  }

  @override
  int get hashCode =>
      key.hashCode ^ itemId.hashCode ^ secondCategoryId.hashCode;
}

/// generated route for
/// [_i13.FeedbackScreen]
class FeedbackRoute extends _i33.PageRouteInfo<void> {
  const FeedbackRoute({List<_i33.PageRouteInfo>? children})
    : super(FeedbackRoute.name, initialChildren: children);

  static const String name = 'FeedbackRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i13.FeedbackScreen();
    },
  );
}

/// generated route for
/// [_i14.HomeScreen]
class HomeRoute extends _i33.PageRouteInfo<void> {
  const HomeRoute({List<_i33.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i14.HomeScreen();
    },
  );
}

/// generated route for
/// [_i15.LoginScreen]
class LoginRoute extends _i33.PageRouteInfo<void> {
  const LoginRoute({List<_i33.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i15.LoginScreen();
    },
  );
}

/// generated route for
/// [_i16.MapPickerScreen]
class MapPickerRoute extends _i33.PageRouteInfo<MapPickerRouteArgs> {
  MapPickerRoute({
    _i34.Key? key,
    double? initialLatitude,
    double? initialLongitude,
    List<_i33.PageRouteInfo>? children,
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

  static _i33.PageInfo page = _i33.PageInfo(
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

  final _i34.Key? key;

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
class MuneManagerRoute extends _i33.PageRouteInfo<void> {
  const MuneManagerRoute({List<_i33.PageRouteInfo>? children})
    : super(MuneManagerRoute.name, initialChildren: children);

  static const String name = 'MuneManagerRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i17.MuneManagerScreen();
    },
  );
}

/// generated route for
/// [_i18.MuneScreen]
class MuneRoute extends _i33.PageRouteInfo<MuneRouteArgs> {
  MuneRoute({
    _i34.Key? key,
    required String secondId,
    required String itemId,
    String? openColseTimes,
    List<_i33.PageRouteInfo>? children,
  }) : super(
         MuneRoute.name,
         args: MuneRouteArgs(
           key: key,
           secondId: secondId,
           itemId: itemId,
           openColseTimes: openColseTimes,
         ),
         initialChildren: children,
       );

  static const String name = 'MuneRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MuneRouteArgs>();
      return _i18.MuneScreen(
        key: args.key,
        secondId: args.secondId,
        itemId: args.itemId,
        openColseTimes: args.openColseTimes,
      );
    },
  );
}

class MuneRouteArgs {
  const MuneRouteArgs({
    this.key,
    required this.secondId,
    required this.itemId,
    this.openColseTimes,
  });

  final _i34.Key? key;

  final String secondId;

  final String itemId;

  final String? openColseTimes;

  @override
  String toString() {
    return 'MuneRouteArgs{key: $key, secondId: $secondId, itemId: $itemId, openColseTimes: $openColseTimes}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MuneRouteArgs) return false;
    return key == other.key &&
        secondId == other.secondId &&
        itemId == other.itemId &&
        openColseTimes == other.openColseTimes;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      secondId.hashCode ^
      itemId.hashCode ^
      openColseTimes.hashCode;
}

/// generated route for
/// [_i19.NavigationControllerScreen]
class NavigationControllerRoute
    extends _i33.PageRouteInfo<NavigationControllerRouteArgs> {
  NavigationControllerRoute({
    _i34.Key? key,
    int initialIndex = 0,
    List<_i33.PageRouteInfo>? children,
  }) : super(
         NavigationControllerRoute.name,
         args: NavigationControllerRouteArgs(
           key: key,
           initialIndex: initialIndex,
         ),
         initialChildren: children,
       );

  static const String name = 'NavigationControllerRoute';

  static _i33.PageInfo page = _i33.PageInfo(
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

  final _i34.Key? key;

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
class NearbyMapRoute extends _i33.PageRouteInfo<void> {
  const NearbyMapRoute({List<_i33.PageRouteInfo>? children})
    : super(NearbyMapRoute.name, initialChildren: children);

  static const String name = 'NearbyMapRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i20.NearbyMapScreen();
    },
  );
}

/// generated route for
/// [_i21.NotificationDetailsScreen]
class NotificationDetailsRoute extends _i33.PageRouteInfo<void> {
  const NotificationDetailsRoute({List<_i33.PageRouteInfo>? children})
    : super(NotificationDetailsRoute.name, initialChildren: children);

  static const String name = 'NotificationDetailsRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i21.NotificationDetailsScreen();
    },
  );
}

/// generated route for
/// [_i22.NotificationScreen]
class NotificationRoute extends _i33.PageRouteInfo<void> {
  const NotificationRoute({List<_i33.PageRouteInfo>? children})
    : super(NotificationRoute.name, initialChildren: children);

  static const String name = 'NotificationRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i22.NotificationScreen();
    },
  );
}

/// generated route for
/// [_i23.OffersScreen]
class OffersRoute extends _i33.PageRouteInfo<void> {
  const OffersRoute({List<_i33.PageRouteInfo>? children})
    : super(OffersRoute.name, initialChildren: children);

  static const String name = 'OffersRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i23.OffersScreen();
    },
  );
}

/// generated route for
/// [_i24.OnboardingScreen]
class OnboardingRoute extends _i33.PageRouteInfo<void> {
  const OnboardingRoute({List<_i33.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i24.OnboardingScreen();
    },
  );
}

/// generated route for
/// [_i25.ProfileScreen]
class ProfileRoute extends _i33.PageRouteInfo<void> {
  const ProfileRoute({List<_i33.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i25.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i26.ProfileStaticScreen]
class ProfileStaticRoute extends _i33.PageRouteInfo<ProfileStaticRouteArgs> {
  ProfileStaticRoute({
    _i34.Key? key,
    required String pageId,
    List<_i33.PageRouteInfo>? children,
  }) : super(
         ProfileStaticRoute.name,
         args: ProfileStaticRouteArgs(key: key, pageId: pageId),
         initialChildren: children,
       );

  static const String name = 'ProfileStaticRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfileStaticRouteArgs>();
      return _i26.ProfileStaticScreen(key: args.key, pageId: args.pageId);
    },
  );
}

class ProfileStaticRouteArgs {
  const ProfileStaticRouteArgs({this.key, required this.pageId});

  final _i34.Key? key;

  final String pageId;

  @override
  String toString() {
    return 'ProfileStaticRouteArgs{key: $key, pageId: $pageId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProfileStaticRouteArgs) return false;
    return key == other.key && pageId == other.pageId;
  }

  @override
  int get hashCode => key.hashCode ^ pageId.hashCode;
}

/// generated route for
/// [_i27.QrCodeScreen]
class QrCodeRoute extends _i33.PageRouteInfo<void> {
  const QrCodeRoute({List<_i33.PageRouteInfo>? children})
    : super(QrCodeRoute.name, initialChildren: children);

  static const String name = 'QrCodeRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i27.QrCodeScreen();
    },
  );
}

/// generated route for
/// [_i28.RatingsScreen]
class RatingsRoute extends _i33.PageRouteInfo<void> {
  const RatingsRoute({List<_i33.PageRouteInfo>? children})
    : super(RatingsRoute.name, initialChildren: children);

  static const String name = 'RatingsRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i28.RatingsScreen();
    },
  );
}

/// generated route for
/// [_i29.RegisterScreen]
class RegisterRoute extends _i33.PageRouteInfo<void> {
  const RegisterRoute({List<_i33.PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i29.RegisterScreen();
    },
  );
}

/// generated route for
/// [_i30.ServicesManagerScreen]
class ServicesManagerRoute extends _i33.PageRouteInfo<void> {
  const ServicesManagerRoute({List<_i33.PageRouteInfo>? children})
    : super(ServicesManagerRoute.name, initialChildren: children);

  static const String name = 'ServicesManagerRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i30.ServicesManagerScreen();
    },
  );
}

/// generated route for
/// [_i31.SplashScreen]
class SplashRoute extends _i33.PageRouteInfo<void> {
  const SplashRoute({List<_i33.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i31.SplashScreen();
    },
  );
}

/// generated route for
/// [_i32.UpdateProfileScreen]
class UpdateProfileRoute extends _i33.PageRouteInfo<void> {
  const UpdateProfileRoute({List<_i33.PageRouteInfo>? children})
    : super(UpdateProfileRoute.name, initialChildren: children);

  static const String name = 'UpdateProfileRoute';

  static _i33.PageInfo page = _i33.PageInfo(
    name,
    builder: (data) {
      return const _i32.UpdateProfileScreen();
    },
  );
}
