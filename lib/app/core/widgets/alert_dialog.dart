import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../../../generated/locale_keys.g.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import 'primary_button.dart';

Future<void> alertDialog({
  required BuildContext context,
  required String message,
  String approveButtonTitle = LocaleKeys.retry,
  required Function onConfirm,
  String rejectButtonTitle = LocaleKeys.cancel,
  Function? onCancel,
  Color? approveButtonColor,
  Color? rejectButtonColor,
  String? subtitle,
  String? icon,
  bool isTwoButtons = true,
  Widget? actions,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: REdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        backgroundColor: ColorManager.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            16.verticalSpace,
            if (icon != null) ...[
              CircleAvatar(
                radius: 32.r,
                backgroundColor: ColorManager.primarySwatch[50],
                child: SvgPicture.asset(icon, width: 24.w, height: 24.h),
              ),
              24.verticalSpace,
            ],
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 25.w),
              child: Text(
                message,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 22),
                textAlign: TextAlign.center,
              ),
            ),
            if (subtitle != null) ...[
              8.verticalSpace,
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 25.w),
                child: Text(subtitle, style: Theme.of(context).textTheme.displayMedium, textAlign: TextAlign.center),
              ),
            ],

            if (actions != null) ...[16.verticalSpace, actions],
            20.verticalSpace,
            Padding(
              padding: REdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryButton(
                    text: approveButtonTitle.tr(),
                    onPressed: () {
                      Navigator.of(context).pop();
                      onConfirm();
                    },
                    backgroundColor: approveButtonColor,
                    borederColor: approveButtonColor,
                  ),
                  const SizedBox(width: 8),
                  if (isTwoButtons) ...[
                    16.verticalSpace,
                    PrimaryButton(
                      text: rejectButtonTitle.tr(),
                      isLight: true,
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (onCancel != null) {
                          onCancel();
                        }
                      },
                      backgroundColor: rejectButtonColor,
                      borederColor: rejectButtonColor ?? Colors.white,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget getAnimatedImage(String animationName) {
  return SizedBox(width: 100.w, height: 100.w, child: Lottie.asset(animationName));
}

void progressDialog({required BuildContext context}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return PopScope(canPop: false, child: Center(child: getAnimatedImage(JsonManager.loading)));
    },
  );
}
