import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/onboarding/data/models/onboarding_message_model.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class OnboardingAdminMessageDialog extends StatelessWidget {
  final OnboardingMessageModel message;
  final VoidCallback? onPressed;

  const OnboardingAdminMessageDialog({super.key, required this.message, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final btnText = (message.btn ?? '').trim();

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(color: ColorManager.white, borderRadius: BorderRadius.circular(16.r)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message.message ?? '',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: ColorManager.black),
            ),
            12.verticalSpace,
            if ((message.image ?? '').trim().isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  message.image!,
                  height: 160.h,
                  width: double.infinity,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => SizedBox(height: 160.h),
                ),
              ),
            16.verticalSpace,
            PrimaryButton(
              text: btnText.isNotEmpty ? btnText : LocaleKeys.ok.tr(),
              onPressed: onPressed ?? () => Navigator.of(context).pop(),
              isLight: false,
              width: double.infinity,
              height: 45.h,
              withShadow: true,
            ),
            16.verticalSpace,
            PrimaryButton(
              text: LocaleKeys.cancel.tr(),
              onPressed: () => Navigator.of(context).pop(),
              isLight: true,
              width: double.infinity,
              height: 45.h,
              withShadow: true,
            ),
          ],
        ),
      ),
    );
  }
}
