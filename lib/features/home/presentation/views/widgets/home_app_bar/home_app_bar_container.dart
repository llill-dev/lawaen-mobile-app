import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../app/resources/color_manager.dart';

class HomeAppBarContainer extends StatelessWidget {
  final Widget child;
  const HomeAppBarContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: ColorManager.homeAppBarGradient,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(30.r),
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
