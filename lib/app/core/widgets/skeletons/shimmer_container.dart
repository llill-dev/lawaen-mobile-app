import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;
  final Color? color;

  const ShimmerBox({super.key, required this.width, required this.height, this.borderRadius, this.color});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: Duration(seconds: 3),
      interval: Duration(seconds: 5),
      color: color ?? ColorManager.lightGrey,
      enabled: true,
      direction: ShimmerDirection.fromLTRB(),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? ColorManager.lightGrey,
          borderRadius: borderRadius ?? BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}
