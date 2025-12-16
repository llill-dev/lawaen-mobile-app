import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../app/resources/color_manager.dart';

class HomeAppBarContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  const HomeAppBarContainer({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: ColorManager.primary,
        // gradient: LinearGradient(
        //   colors: ColorManager.homeAppBarGradient,
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        // ),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.r), bottomRight: Radius.circular(30.r)),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.2),
            spreadRadius: -4,
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.2),
            spreadRadius: -3,
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}
