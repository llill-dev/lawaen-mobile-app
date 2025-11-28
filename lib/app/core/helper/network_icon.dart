import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NetworkIcon extends StatelessWidget {
  final String url;
  final double? size;

  const NetworkIcon({super.key, required this.url, this.size});

  bool get _isSvg => url.toLowerCase().endsWith(".svg");

  @override
  Widget build(BuildContext context) {
    if (_isSvg) {
      return SvgPicture.network(url, height: size, width: size);
    } else {
      return CachedNetworkImage(imageUrl: url, height: size, width: size);
    }
  }
}
