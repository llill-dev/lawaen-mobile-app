import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class CustomAuthContainer extends StatelessWidget {
  const CustomAuthContainer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        child: child,
      ),
    );
  }
}
