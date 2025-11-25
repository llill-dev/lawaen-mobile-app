import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lawaen/app/location_manager/location_service.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';

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
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.router.replace(NavigationControllerRoute());
      }
    });
  }

  void refreshUserLocation() async {
    final locService = getIt<LocationService>();

    // Fast cached location (optional to use)
    await locService.getBestEffortLocation();

    // Try updating with real GPS
    try {
      await locService.getCurrentLocation();
    } catch (_) {
      // No need to show anything — fallback already exists
    }
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
