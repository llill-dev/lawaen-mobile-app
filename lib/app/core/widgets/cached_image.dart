import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../resources/color_manager.dart';

final CacheManager _imageCacheManager = CacheManager(
  Config('optimizedImageCache', stalePeriod: const Duration(days: 7), maxNrOfCacheObjects: 200),
);

class CachedImage extends StatelessWidget {
  final String? url;
  final String? filePath;
  final double? width;
  final double? height;
  final BorderRadius? radius;
  final BoxFit fit;
  final bool withShadow;
  final Color shadowColor;
  final bool withTitle;
  final String? title;
  final bool useShimmer;

  const CachedImage({
    super.key,
    this.url,
    this.filePath,
    this.width,
    this.height,
    this.radius,
    this.fit = BoxFit.cover,
    this.withShadow = false,
    this.shadowColor = ColorManager.black,
    this.withTitle = false,
    this.title,
    this.useShimmer = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget image;

    /// 1️⃣ Local file (fastest)
    if (filePath != null && File(filePath!).existsSync()) {
      image = Image.file(File(filePath!), fit: fit, width: width, height: height);
    }
    /// 2️⃣ Network image
    else if (url != null && url!.isNotEmpty) {
      image = CachedNetworkImage(
        cacheManager: _imageCacheManager,
        imageUrl: url!,
        width: width,
        height: height,
        fit: fit,
        memCacheWidth: width?.isInfinite ?? false ? null : width?.toInt(),
        memCacheHeight: height?.isInfinite ?? false ? null : height?.toInt(),
        fadeInDuration: const Duration(milliseconds: 150),
        fadeOutDuration: const Duration(milliseconds: 100),
        placeholder: (_, _) => _buildPlaceholder(),
        errorWidget: (_, _, _) => const Icon(Icons.broken_image),
      );
    }
    /// 3️⃣ Fallback
    else {
      image = _buildPlaceholder(icon: Icons.person);
    }

    return Stack(
      children: [
        ClipRRect(borderRadius: radius ?? BorderRadius.zero, child: image),

        /// Shadow overlay
        if (withShadow)
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: radius,
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [shadowColor.withOpacity(0.6), Colors.transparent],
                ),
              ),
            ),
          ),

        /// Title
        if (withTitle && title != null)
          Positioned(
            left: 8.w,
            bottom: 12.h,
            child: Text(title!, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorManager.white)),
          ),
      ],
    );
  }

  Widget _buildPlaceholder({IconData? icon}) {
    return Container(
      width: width,
      height: height,
      color: ColorManager.lightGrey,
      alignment: Alignment.center,
      child: icon != null
          ? Icon(icon, color: ColorManager.grey)
          : useShimmer
          ? const CircularProgressIndicator(strokeWidth: 1.5)
          : null,
    );
  }
}
