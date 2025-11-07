import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../resources/color_manager.dart';

class ShimmerLoadingWidget extends StatelessWidget {
  final double height;
  final double width;
  final BorderRadius borderRadius;

  const ShimmerLoadingWidget({
    super.key,
    required this.height,
    required this.width,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Shimmer.fromColors(
        baseColor: ColorManager.blackSwatch[5] ?? Colors.grey.shade300,
        highlightColor: ColorManager.blackSwatch[3] ?? Colors.grey.shade100,
        child: Container(color: ColorManager.blackSwatch[5] ?? Colors.grey.shade300, height: height, width: width),
      ),
    );
  }
}
