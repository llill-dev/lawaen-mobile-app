// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;
import 'package:lawaen/features/home/presentation/views/category_details_screen.dart'
    as _i1;
import 'package:lawaen/features/home/presentation/views/category_screen.dart'
    as _i2;
import 'package:lawaen/features/home/presentation/views/home_screen.dart'
    as _i3;
import 'package:lawaen/features/home/presentation/views/navigation_controller.dart'
    as _i4;
import 'package:lawaen/features/home/presentation/views/notification_details_screen.dart'
    as _i5;
import 'package:lawaen/features/home/presentation/views/notification_screen.dart'
    as _i6;
import 'package:lawaen/features/splash/presentation/views/splash_screen.dart'
    as _i7;

/// generated route for
/// [_i1.CategoryDetailsScreen]
class CategoryDetailsRoute extends _i8.PageRouteInfo<void> {
  const CategoryDetailsRoute({List<_i8.PageRouteInfo>? children})
    : super(CategoryDetailsRoute.name, initialChildren: children);

  static const String name = 'CategoryDetailsRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i1.CategoryDetailsScreen();
    },
  );
}

/// generated route for
/// [_i2.CategoryScreen]
class CategoryRoute extends _i8.PageRouteInfo<void> {
  const CategoryRoute({List<_i8.PageRouteInfo>? children})
    : super(CategoryRoute.name, initialChildren: children);

  static const String name = 'CategoryRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i2.CategoryScreen();
    },
  );
}

/// generated route for
/// [_i3.HomeScreen]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomeScreen();
    },
  );
}

/// generated route for
/// [_i4.NavigationControllerScreen]
class NavigationControllerRoute
    extends _i8.PageRouteInfo<NavigationControllerRouteArgs> {
  NavigationControllerRoute({
    _i9.Key? key,
    int initialIndex = 0,
    List<_i8.PageRouteInfo>? children,
  }) : super(
         NavigationControllerRoute.name,
         args: NavigationControllerRouteArgs(
           key: key,
           initialIndex: initialIndex,
         ),
         initialChildren: children,
       );

  static const String name = 'NavigationControllerRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NavigationControllerRouteArgs>(
        orElse: () => const NavigationControllerRouteArgs(),
      );
      return _i4.NavigationControllerScreen(
        key: args.key,
        initialIndex: args.initialIndex,
      );
    },
  );
}

class NavigationControllerRouteArgs {
  const NavigationControllerRouteArgs({this.key, this.initialIndex = 0});

  final _i9.Key? key;

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
/// [_i5.NotificationDetailsScreen]
class NotificationDetailsRoute extends _i8.PageRouteInfo<void> {
  const NotificationDetailsRoute({List<_i8.PageRouteInfo>? children})
    : super(NotificationDetailsRoute.name, initialChildren: children);

  static const String name = 'NotificationDetailsRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i5.NotificationDetailsScreen();
    },
  );
}

/// generated route for
/// [_i6.NotificationScreen]
class NotificationRoute extends _i8.PageRouteInfo<void> {
  const NotificationRoute({List<_i8.PageRouteInfo>? children})
    : super(NotificationRoute.name, initialChildren: children);

  static const String name = 'NotificationRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i6.NotificationScreen();
    },
  );
}

/// generated route for
/// [_i7.SplashScreen]
class SplashRoute extends _i8.PageRouteInfo<void> {
  const SplashRoute({List<_i8.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i7.SplashScreen();
    },
  );
}
