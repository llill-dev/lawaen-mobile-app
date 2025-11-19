import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

@RoutePage()
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: ColorManager.onBoardingGradient,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
            child: Column(
              children: [
                Text(
                  LocaleKeys.onBoardingTitle.tr(),
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(color: ColorManager.white, fontSize: 24),
                ),
                24.verticalSpace,
                Image.asset(ImageManager.onboarding),
                12.verticalSpace,
                Text(
                  LocaleKeys.onBoardingMessage.tr(),
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: ColorManager.white),
                ),
                24.verticalSpace,
                PrimaryButton(
                  text: LocaleKeys.next.tr(),
                  onPressed: () => context.pushRoute(LoginRoute()),
                  textColor: ColorManager.black,
                  backgroundColor: ColorManager.white,
                  borederColor: ColorManager.white,
                  withShadow: true,
                  shadowColor: ColorManager.onBoardingShadowColor,
                  height: 45.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
