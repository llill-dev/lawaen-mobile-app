import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/auth/presentation/views/widget/auth_gradient_container.dart';
import 'package:lawaen/features/auth/presentation/views/widget/custom_auth_container.dart';
import 'package:lawaen/features/auth/presentation/views/widget/custom_auth_image.dart';
import 'package:lawaen/features/auth/presentation/views/widget/otp/otp_verification_form.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

@RoutePage()
class OtpVerificationScreen extends StatelessWidget {
  final String contact;
  const OtpVerificationScreen({super.key, this.contact = ''});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthGradientContainer(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const CustomAuthImage(),
              CustomAuthContainer(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(LocaleKeys.otpVerification.tr(), style: Theme.of(context).textTheme.headlineLarge),
                      12.verticalSpace,
                      Text(
                        LocaleKeys.enterOtpCode.tr(),
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.grey),
                        textAlign: TextAlign.center,
                      ),
                      if (contact.isNotEmpty) ...[
                        8.verticalSpace,
                        Text(
                          contact,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.darkGrey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                      24.verticalSpace,
                      OtpVerificationForm(contact: contact),
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
