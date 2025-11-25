import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:lawaen/features/auth/presentation/views/widget/auth_gradient_container.dart';
import 'package:lawaen/features/auth/presentation/views/widget/custom_auth_container.dart';
import 'package:lawaen/features/auth/presentation/views/widget/custom_auth_image.dart';
import 'package:lawaen/features/auth/presentation/views/widget/register/register_form.dart';
import 'package:lawaen/features/auth/presentation/views/widget/register/upload_profile_image.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

@RoutePage()
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = getIt<AuthCubit>();
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
                      Text(LocaleKeys.signUp.tr(), style: Theme.of(context).textTheme.headlineLarge),
                      12.verticalSpace,
                      Text(
                        LocaleKeys.enterDetailsToAccessAccount.tr(),
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.grey),
                      ),
                      24.verticalSpace,
                      UploadProfileImage(authCubit: authCubit),
                      24.verticalSpace,
                      RegisterForm(authCubit: authCubit),
                      12.verticalSpace,
                      PrimaryButton(
                        text: LocaleKeys.skip.tr(),
                        backgroundColor: ColorManager.blackSwatch[4],
                        borederColor: ColorManager.blackSwatch[4],
                        textColor: ColorManager.black,
                        withShadow: true,
                        shadowColor: ColorManager.onBoardingShadowColor,
                        onPressed: () {},
                        height: 40.h,
                      ),
                      24.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(LocaleKeys.alreadyHaveAccount.tr(), style: Theme.of(context).textTheme.headlineSmall),
                          4.horizontalSpace,
                          GestureDetector(
                            onTap: () {
                              context.router.replace(LoginRoute());
                            },
                            child: Text(
                              LocaleKeys.signIn.tr(),
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.black),
                            ),
                          ),
                        ],
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
