import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../resources/color_manager.dart';

class CachedImage extends StatelessWidget {
  final String? url; // Image from URL
  final String? filePath; // Image from local storage
  final double width;
  final double height;
  final BorderRadius? radius;
  final BoxFit fit;
  final bool? withShadow;
  final Color? shadowColor;
  final bool? withTitle;
  final String? title;

  const CachedImage({
    this.url,
    this.filePath,
    required this.width,
    required this.height,
    this.radius,
    this.withShadow,
    this.shadowColor = ColorManager.black,
    this.withTitle,
    this.title,
    super.key,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (filePath != null && File(filePath!).existsSync()) {
      // Show local image if available
      imageWidget = Image.file(File(filePath!), fit: fit, width: width, height: height);
    } else if (url != null) {
      // Fallback to network image
      imageWidget = CachedNetworkImage(
        imageUrl: url!,
        fit: fit,
        width: width,
        height: height,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: ColorManager.blackSwatch[5] ?? Colors.grey.shade300,
          highlightColor: ColorManager.blackSwatch[3] ?? Colors.grey.shade100,
          child: Container(color: ColorManager.blackSwatch[5] ?? Colors.grey.shade300, width: width, height: height),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    } else {
      // Placeholder if no image is provided
      imageWidget = Container(width: width, height: height, color: Colors.grey, child: const Icon(Icons.person));
    }

    return Stack(
      children: [
        ClipRRect(borderRadius: radius ?? BorderRadius.circular(0), child: imageWidget),
        if (withShadow ?? false)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: height,
            child: ClipRRect(
              borderRadius: radius ?? BorderRadius.circular(0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [shadowColor!.withOpacity(0.8), Colors.transparent],
                  ),
                ),
              ),
            ),
          ),
        if (withTitle ?? false)
          Positioned(
            left: 8.w,
            bottom: 12.h,
            child: Text(title ?? "", style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: ColorManager.white)),
          ),
      ],
    );
  }
}
