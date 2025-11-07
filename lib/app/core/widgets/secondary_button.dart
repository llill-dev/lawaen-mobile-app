import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/color_manager.dart';

class SecondaryButton extends StatelessWidget {
  SecondaryButton({
    this.isLoading = false,
    this.icon,
    this.text,
    this.isOutLine = false,
    this.borderRadius = 8,
    this.width,
    this.height,
    this.textColor,
    this.backgroundColor,
    this.onPressed,
    super.key,
  }) {
    assert((text != null) ^ (icon != null), 'You should either provide the text or the icon, and not both of them');
  }

  final String? text;
  final Icon? icon;
  final bool isLoading;
  final bool isOutLine;
  final double borderRadius;
  final double? width;
  final double? height;
  final Color? textColor;
  final VoidCallback? onPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: width ?? .9.sw,
        height: height ?? 54.h,
        decoration: BoxDecoration(
          color: isOutLine ? null : textColor ?? ColorManager.primary,
          borderRadius: BorderRadius.circular(borderRadius.r),
          border: isOutLine ? Border.all(color: textColor ?? ColorManager.primary) : null,
        ),
        alignment: Alignment.center,
        padding: REdgeInsetsDirectional.only(top: 12.h, bottom: 12.h),
        child: isLoading
            ? SizedBox(
                width: 24.r,
                height: 24.r,
                child: CircularProgressIndicator(
                  color: textColor ?? (isOutLine ? ColorManager.primary : ColorManager.white),
                ),
              )
            : text != null
            ? AutoSizeText(
                text ?? "",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: textColor ?? (isOutLine ? ColorManager.primary : ColorManager.white),
                ),
              )
            : icon,
      ),
    );
  }
}
