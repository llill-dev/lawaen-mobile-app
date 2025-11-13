import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/color_manager.dart';

import '../../../../../../app/text_direction_utils.dart';

class Bubble extends StatelessWidget {
  final String message;
  final bool isSender;

  const Bubble({super.key, required this.message, required this.isSender});

  @override
  Widget build(BuildContext context) {
    final isArabicText = TextDirectionUtils.isArabic(message);
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        constraints: BoxConstraints(maxWidth: 280.w),
        decoration: BoxDecoration(
          color: isSender ? ColorManager.nPrimarySwatch[12] : ColorManager.nPrimarySwatch[9],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
            bottomLeft: isSender ? Radius.circular(20.r) : Radius.circular(5.r),
            bottomRight: isSender ? Radius.circular(5.r) : Radius.circular(20.r),
          ),
        ),
        child: Directionality(
          textDirection: TextDirectionUtils.getTextDirection(message),
          child: Text(
            message,
            textAlign: isArabicText ? TextAlign.right : TextAlign.left,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.white),
          ),
        ),
      ),
    );
  }
}
