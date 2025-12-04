import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lawaen/app/app_prefs.dart';
import 'package:lawaen/app/core/helper/jwt_helper.dart';
import 'package:lawaen/app/location_manager/location_service.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/auth/data/repo/auth_repo.dart';
import '../../../../app/resources/assets_manager.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    refreshUserLocation();
    _decideNavigation();
  }

  void refreshUserLocation() async {
    final locService = getIt<LocationService>();
    try {
      await locService.getCurrentLocation();
    } catch (_) {}
  }

  Future<void> _decideNavigation() async {
    final prefs = getIt<AppPreferences>();
    final authRepo = getIt<AuthRepo>();

    await Future.delayed(const Duration(seconds: 3));

    final isUserFirstTime = prefs.isFirstTime;
    final token = prefs.accessToken;
    final hasToken = token.isNotEmpty;

    if (!mounted) return;

    if (isUserFirstTime && !hasToken) {
      prefs.setBool(prefsKey: isFisrtTime, value: false);
      context.router.replace(OnboardingRoute());
      return;
    }
    if (!hasToken) {
      //context.router.replace(const LoginRoute());
      prefs.setBool(prefsKey: prefsGuest, value: true);
      context.router.replace(NavigationControllerRoute());
      return;
    }

    final isValid = JwtHelper.isValid(token, leeway: const Duration(seconds: 10));

    if (isValid) {
      context.router.replace(NavigationControllerRoute());
      return;
    }

    final refreshResult = await authRepo.refreshToken();

    if (!mounted) return;

    refreshResult.fold(
      (error) async {
        log(error.errorMessage.toString());
        await prefs.logout();
        if (mounted) {
          context.router.replace(const LoginRoute());
        }
      },
      (_) {
        if (mounted) {
          context.router.replace(NavigationControllerRoute());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(
        child: Image(image: AssetImage(ImageManager.logo), fit: BoxFit.cover),
      ),
    );
  }
}
