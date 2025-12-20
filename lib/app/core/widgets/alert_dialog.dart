import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../generated/locale_keys.g.dart';
import '../../resources/color_manager.dart';
import 'primary_button.dart';

Future<void> alertDialog({
  required BuildContext context,
  required String message,
  String approveButtonTitle = LocaleKeys.retry,
  required Function onConfirm,
  String rejectButtonTitle = LocaleKeys.cancel,
  Function? onCancel,
  bool isError = false,
  String? subtitle,
  IconData? icon,
  Widget? actions,
  bool isTwoButtons = true,
  Color? approveButtonColor,
  Color? iconcolor,
  Color? rejectButtonColor,
}) {
  final Color primary = ColorManager.primary;

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withOpacity(.45),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 12.w, right: 12.w),
        child: Material(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isError)
                  Icon(icon ?? Icons.error_outline_outlined, color: iconcolor ?? ColorManager.red, size: 46.r),

                if (!isError && icon != null) Icon(icon, size: 46.r, color: iconcolor ?? primary),

                14.verticalSpace,

                Text(message, textAlign: TextAlign.center, style: Theme.of(context).textTheme.displayLarge),

                if (subtitle != null) ...[
                  8.verticalSpace,
                  Text(subtitle, textAlign: TextAlign.center, style: Theme.of(context).textTheme.displayMedium),
                ],

                if (actions != null) ...[16.verticalSpace, actions],

                20.verticalSpace,

                /// Buttons row
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        text: approveButtonTitle.tr(),
                        onPressed: () {
                          Navigator.of(context).pop();
                          onConfirm();
                        },
                        backgroundColor: approveButtonColor ?? (isError ? ColorManager.red : primary),
                        borederColor: approveButtonColor ?? (isError ? ColorManager.red : primary),
                      ),
                    ),
                    if (isTwoButtons) ...[
                      12.horizontalSpace,
                      Expanded(
                        child: PrimaryButton(
                          text: rejectButtonTitle.tr(),
                          isLight: true,
                          backgroundColor: rejectButtonColor ?? ColorManager.white,
                          borederColor: rejectButtonColor ?? ColorManager.white,
                          onPressed: () {
                            Navigator.of(context).pop();
                            if (onCancel != null) onCancel();
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
