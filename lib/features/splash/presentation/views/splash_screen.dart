import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lawaen/app/app_prefs.dart';
import 'package:lawaen/app/core/helper/jwt_helper.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
import 'package:lawaen/app/location_manager/location_service.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/auth/data/repo/auth_repo.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoAnimation;

  late AnimationController _textController;
  late Animation<int> _textAnimation;

  final String _animatedText = "Your services, connected.";

  late final SplashCubit _cubit;

  @override
  void initState() {
    super.initState();

    /// Logo animation
    _logoController = AnimationController(duration: const Duration(milliseconds: 1200), vsync: this)..forward();

    _logoAnimation = CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack);

    /// Text animation
    _textController = AnimationController(duration: const Duration(seconds: 2), vsync: this);

    _textAnimation = StepTween(begin: 0, end: _animatedText.length).animate(_textController);

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) _textController.forward();
    });

    _refreshUserLocation();

    _cubit = getIt<SplashCubit>();

    _cubit.checkInternetAndProceed();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _refreshUserLocation() async {
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
      prefs.setGuest(true);
      context.router.replace(OnboardingRoute());
      return;
    }

    if (!hasToken) {
      prefs.setGuest(true);
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

  void _showNoInternetDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: ColorManager.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.wifi_off, color: ColorManager.red),
            const SizedBox(width: 12),
            Flexible(
              child: Text(LocaleKeys.noInternetConnection.tr(), style: Theme.of(context).textTheme.displayMedium),
            ),
          ],
        ),
        content: Text(LocaleKeys.checkYourConnection.tr(), style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          PrimaryButton(
            text: LocaleKeys.retry.tr(),
            onPressed: () {
              Navigator.of(context).pop();
              _cubit.checkInternetAndProceed();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return BlocListener<SplashCubit, SplashState>(
      bloc: _cubit,
      listener: (context, state) {
        if (state is SplashNoInternet) {
          _showNoInternetDialog();
        }

        if (state is SplashNavigate) {
          _decideNavigation();
        }
      },
      child: Scaffold(
        backgroundColor: ColorManager.primary,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ScaleTransition(
                scale: _logoAnimation,
                child: FadeTransition(
                  opacity: _logoAnimation,
                  child: Image.asset(ImageManager.logo, width: width * 0.45),
                ),
              ),
              const SizedBox(height: 20),
              AnimatedBuilder(
                animation: _textAnimation,
                builder: (_, __) {
                  return Text(
                    _animatedText.substring(0, _textAnimation.value),
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white),
                  );
                },
              ),
              BlocBuilder<SplashCubit, SplashState>(
                bloc: _cubit,
                builder: (_, state) {
                  if (state is SplashCheckingNetwork) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
