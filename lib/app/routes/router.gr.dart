// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/material.dart' as _i13;
import 'package:lawaen/features/home/presentation/views/category_details_screen.dart'
    as _i1;
import 'package:lawaen/features/home/presentation/views/category_item_detials_screen.dart'
    as _i2;
import 'package:lawaen/features/home/presentation/views/category_screen.dart'
    as _i3;
import 'package:lawaen/features/home/presentation/views/feedback_chat_screen.dart'
    as _i4;
import 'package:lawaen/features/home/presentation/views/feedback_screen.dart'
    as _i5;
import 'package:lawaen/features/home/presentation/views/home_screen.dart'
    as _i6;
import 'package:lawaen/features/home/presentation/views/mune_screen.dart'
    as _i7;
import 'package:lawaen/features/home/presentation/views/navigation_controller.dart'
    as _i8;
import 'package:lawaen/features/home/presentation/views/notification_details_screen.dart'
    as _i9;
import 'package:lawaen/features/home/presentation/views/notification_screen.dart'
    as _i10;
import 'package:lawaen/features/splash/presentation/views/splash_screen.dart'
    as _i11;

/// generated route for
/// [_i1.CategoryDetailsScreen]
class CategoryDetailsRoute extends _i12.PageRouteInfo<void> {
  const CategoryDetailsRoute({List<_i12.PageRouteInfo>? children})
    : super(CategoryDetailsRoute.name, initialChildren: children);

  static const String name = 'CategoryDetailsRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i1.CategoryDetailsScreen();
    },
  );
}

/// generated route for
/// [_i2.CategoryItemDetialsScreen]
class CategoryItemDetialsRoute extends _i12.PageRouteInfo<void> {
  const CategoryItemDetialsRoute({List<_i12.PageRouteInfo>? children})
    : super(CategoryItemDetialsRoute.name, initialChildren: children);

  static const String name = 'CategoryItemDetialsRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i2.CategoryItemDetialsScreen();
    },
  );
}

/// generated route for
/// [_i3.CategoryScreen]
class CategoryRoute extends _i12.PageRouteInfo<void> {
  const CategoryRoute({List<_i12.PageRouteInfo>? children})
    : super(CategoryRoute.name, initialChildren: children);

  static const String name = 'CategoryRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i3.CategoryScreen();
    },
  );
}

/// generated route for
/// [_i4.FeedbackChatScreen]
class FeedbackChatRoute extends _i12.PageRouteInfo<void> {
  const FeedbackChatRoute({List<_i12.PageRouteInfo>? children})
    : super(FeedbackChatRoute.name, initialChildren: children);

  static const String name = 'FeedbackChatRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i4.FeedbackChatScreen();
    },
  );
}

/// generated route for
/// [_i5.FeedbackScreen]
class FeedbackRoute extends _i12.PageRouteInfo<void> {
  const FeedbackRoute({List<_i12.PageRouteInfo>? children})
    : super(FeedbackRoute.name, initialChildren: children);

  static const String name = 'FeedbackRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i5.FeedbackScreen();
    },
  );
}

/// generated route for
/// [_i6.HomeScreen]
class HomeRoute extends _i12.PageRouteInfo<void> {
  const HomeRoute({List<_i12.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i6.HomeScreen();
    },
  );
}

/// generated route for
/// [_i7.MuneScreen]
class MuneRoute extends _i12.PageRouteInfo<void> {
  const MuneRoute({List<_i12.PageRouteInfo>? children})
    : super(MuneRoute.name, initialChildren: children);

  static const String name = 'MuneRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i7.MuneScreen();
    },
  );
}

/// generated route for
/// [_i8.NavigationControllerScreen]
class NavigationControllerRoute
    extends _i12.PageRouteInfo<NavigationControllerRouteArgs> {
  NavigationControllerRoute({
    _i13.Key? key,
    int initialIndex = 0,
    List<_i12.PageRouteInfo>? children,
  }) : super(
         NavigationControllerRoute.name,
         args: NavigationControllerRouteArgs(
           key: key,
           initialIndex: initialIndex,
         ),
         initialChildren: children,
       );

  static const String name = 'NavigationControllerRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NavigationControllerRouteArgs>(
        orElse: () => const NavigationControllerRouteArgs(),
      );
      return _i8.NavigationControllerScreen(
        key: args.key,
        initialIndex: args.initialIndex,
      );
    },
  );
}

class NavigationControllerRouteArgs {
  const NavigationControllerRouteArgs({this.key, this.initialIndex = 0});

  final _i13.Key? key;

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
/// [_i9.NotificationDetailsScreen]
class NotificationDetailsRoute extends _i12.PageRouteInfo<void> {
  const NotificationDetailsRoute({List<_i12.PageRouteInfo>? children})
    : super(NotificationDetailsRoute.name, initialChildren: children);

  static const String name = 'NotificationDetailsRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i9.NotificationDetailsScreen();
    },
  );
}

/// generated route for
/// [_i10.NotificationScreen]
class NotificationRoute extends _i12.PageRouteInfo<void> {
  const NotificationRoute({List<_i12.PageRouteInfo>? children})
    : super(NotificationRoute.name, initialChildren: children);

  static const String name = 'NotificationRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i10.NotificationScreen();
    },
  );
}

/// generated route for
/// [_i11.SplashScreen]
class SplashRoute extends _i12.PageRouteInfo<void> {
  const SplashRoute({List<_i12.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i11.SplashScreen();
    },
  );
}
