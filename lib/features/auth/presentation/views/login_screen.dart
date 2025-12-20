import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/app_prefs.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/auth/presentation/views/widget/login/login_form.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

import 'widget/auth_gradient_container.dart';
import 'widget/custom_auth_container.dart';
import 'widget/custom_auth_image.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthGradientContainer(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              CustomAuthImage(),
              CustomAuthContainer(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(LocaleKeys.welcomeBack.tr(), style: Theme.of(context).textTheme.headlineLarge),
                      12.verticalSpace,
                      Text(
                        LocaleKeys.enterDetailsToAccessAccount.tr(),
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.grey),
                      ),
                      24.verticalSpace,
                      LoginForm(),
                      12.verticalSpace,
                      PrimaryButton(
                        text: LocaleKeys.skip.tr(),
                        backgroundColor: ColorManager.blackSwatch[4],
                        borederColor: ColorManager.blackSwatch[4],
                        textColor: ColorManager.black,
                        //withShadow: true,
                        //shadowColor: ColorManager.onBoardingShadowColor,
                        onPressed: () {
                          final prefs = getIt<AppPreferences>();
                          prefs.setGuest(true);
                          context.router.replace(NavigationControllerRoute());
                        },
                        height: 40.h,
                      ),
                      24.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(LocaleKeys.doNotHaveAnAccount.tr(), style: Theme.of(context).textTheme.headlineSmall),
                          4.horizontalSpace,
                          GestureDetector(
                            onTap: () {
                              context.router.replace(RegisterRoute());
                            },
                            child: Text(
                              LocaleKeys.signUp.tr(),
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.black),
                            ),
                          ),
                        ],
                      ),
                      12.verticalSpace,
                      GestureDetector(
                        onTap: () {
                          context.router.push(const ForgetPasswordRoute());
                        },
                        child: Text(LocaleKeys.forgetPassword.tr(), style: Theme.of(context).textTheme.headlineSmall),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
