import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class AddContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  const AddContainer({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? REdgeInsets.all(24.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: ColorManager.blackSwatch[4]!, width: 2),
        boxShadow: [
          BoxShadow(color: ColorManager.black.withValues(alpha: .25), blurRadius: 4, offset: const Offset(0, 4)),
        ],
      ),
      child: child,
    ).horizontalPadding(padding: 16.w);
  }
}
