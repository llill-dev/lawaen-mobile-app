import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lawaen/app/app_prefs.dart';
import 'package:lawaen/app/core/helper/jwt_helper.dart';
import 'package:lawaen/app/location_manager/location_service.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/auth/data/repo/auth_repo.dart';
import 'package:lawaen/app/resources/assets_manager.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;

  late AnimationController _textController;
  late Animation<int> _textAnimation;

  final String _animatedText = "Your services, connected.";

  @override
  void initState() {
    super.initState();

    /// Logo Animation Controller
    _controller = AnimationController(duration: const Duration(milliseconds: 1200), vsync: this);

    _logoAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);

    _controller.forward();

    /// Text Animation Controller (Typewriter Effect)
    _textController = AnimationController(duration: const Duration(seconds: 2), vsync: this);

    _textAnimation = StepTween(begin: 0, end: _animatedText.length).animate(_textController);

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) _textController.forward();
    });

    refreshUserLocation();
    _decideNavigation();
  }

  @override
  void dispose() {
    _controller.dispose();
    _textController.dispose();
    super.dispose();
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
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Animated Logo
            ScaleTransition(
              scale: _logoAnimation,
              child: FadeTransition(
                opacity: _logoAnimation,
                child: Image.asset(ImageManager.logo, width: width * 0.45),
              ),
            ),

            const SizedBox(height: 20),

            /// Animated Text (Typewriter Effect)
            AnimatedBuilder(
              animation: _textAnimation,
              builder: (context, child) {
                final count = _textAnimation.value;
                return Text(
                  _animatedText.substring(0, count),
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
