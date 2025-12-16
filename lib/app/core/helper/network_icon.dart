import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/core/widgets/cached_image.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:shimmer/shimmer.dart';

class NetworkIcon extends StatelessWidget {
  final String url;
  final double? size;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Color? color;
  final Widget? placeholder;
  const NetworkIcon({
    super.key,
    required this.url,
    this.size,
    this.fit,
    this.width,
    this.height,
    this.color,
    this.placeholder,
  });

  bool get _isSvg => url.toLowerCase().endsWith(".svg");

  @override
  Widget build(BuildContext context) {
    if (_isSvg) {
      return SvgPicture.network(
        url,
        height: size ?? height,
        width: size ?? width,
        fit: fit ?? BoxFit.cover,
        colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        placeholderBuilder: (context) => Shimmer.fromColors(
          baseColor: ColorManager.blackSwatch[5] ?? Colors.grey.shade300,
          highlightColor: ColorManager.blackSwatch[3] ?? Colors.grey.shade100,
          child: Container(color: ColorManager.blackSwatch[5] ?? Colors.grey.shade300, width: size, height: size),
        ),
        errorBuilder: (context, url, error) => const Icon(Icons.error, color: Colors.red),
      );
    } else {
      return CachedImage(url: url, height: size ?? height, width: size ?? width);
    }
  }
}
