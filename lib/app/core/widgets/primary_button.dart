import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/color_manager.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    this.isLoading = false,
    this.icon,
    this.text,
    this.isLight = false,
    this.borderRadius = 8,
    this.width,
    this.height,
    this.textColor,
    this.backgroundColor,
    this.onPressed,
    this.borederColor,
    super.key,
  });

  final String? text;
  final Widget? icon;
  final bool isLoading;
  final bool isLight;
  final double borderRadius;
  final double? width;
  final double? height;
  final Color? textColor;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? borederColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: width ?? 343.w,
        height: height ?? 48.h,
        decoration: BoxDecoration(
          color: backgroundColor ?? (isLight ? ColorManager.white : ColorManager.primarySwatch[500]),
          borderRadius: BorderRadius.circular(borderRadius.r),
          border: Border.all(
            color: borederColor ?? (isLight ? ColorManager.black : ColorManager.primarySwatch[500]!),
            width: 1.5,
          ),
        ),
        alignment: Alignment.center,
        child: isLoading
            ? SizedBox(
                width: 24.r,
                height: 24.r,
                child: CircularProgressIndicator(
                  color: isLight ? ColorManager.primary : textColor ?? ColorManager.white,
                ),
              )
            : Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) icon!,
                  AutoSizeText(
                    text ?? "",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: textColor ?? (isLight ? ColorManager.black : ColorManager.white),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
