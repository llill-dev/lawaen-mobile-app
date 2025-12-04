import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:apple_maps_flutter/apple_maps_flutter.dart' as apple;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' as svg;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:vector_graphics/vector_graphics.dart' as vector;

@lazySingleton
class MarkerIconService {
  final Dio _dio;

  // Cache (subcategory ID => marker icon)
  final Map<String, BitmapDescriptor> _googleCache = {};
  final Map<String, apple.BitmapDescriptor> _appleCache = {};

  MarkerIconService(this._dio);

  // ============================================================
  // PUBLIC API (Google)
  // ============================================================

  Future<BitmapDescriptor> getGoogleIconForSubCategory({
    required String subCategoryId,
    required String svgUrl,
    double size = 40,
  }) async {
    if (_googleCache.containsKey(subCategoryId)) {
      return _googleCache[subCategoryId]!;
    }

    final bytes = await _renderSvgToBytes(svgUrl: svgUrl, size: size, color: ColorManager.primary);

    final icon = BitmapDescriptor.bytes(bytes, width: size, height: size);
    _googleCache[subCategoryId] = icon;
    return icon;
  }

  // ============================================================
  // PUBLIC API (Apple)
  // ============================================================

  Future<apple.BitmapDescriptor> getAppleIconForSubCategory({
    required String subCategoryId,
    required String svgUrl,
    double size = 80,
  }) async {
    if (_appleCache.containsKey(subCategoryId)) {
      return _appleCache[subCategoryId]!;
    }

    final bytes = await _renderSvgToBytes(svgUrl: svgUrl, size: size, color: ColorManager.primary);

    final icon = apple.BitmapDescriptor.fromBytes(bytes);
    _appleCache[subCategoryId] = icon;
    return icon;
  }

  // ============================================================
  // INTERNAL: SVG → PNG Renderer
  // ============================================================

  Future<Uint8List> _renderSvgToBytes({required String svgUrl, required double size, required Color color}) async {
    // 1. Download SVG string
    final response = await _dio.get<String>(svgUrl);
    final svgString = response.data;

    if (svgString == null || svgString.isEmpty) {
      throw Exception("SVG is empty at $svgUrl");
    }

    // 2. Parse SVG into DrawableRoot
    final loader = svg.SvgStringLoader(svgString);
    final pictureInfo = await vector.vg.loadPicture(loader, null);
    final picture = pictureInfo.picture;

    // 3. Scale the picture to the requested size
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final double scaleX = size / (pictureInfo.size.width == 0 ? size : pictureInfo.size.width);
    final double scaleY = size / (pictureInfo.size.height == 0 ? size : pictureInfo.size.height);
    canvas.scale(scaleX, scaleY);
    canvas.drawPicture(picture);
    final scaledPicture = recorder.endRecording();

    // 4. Render picture to Image and apply color override
    final ui.Image baseImage = await scaledPicture.toImage(size.toInt(), size.toInt());
    final ui.PictureRecorder colorRecorder = ui.PictureRecorder();
    final Canvas colorCanvas = Canvas(colorRecorder);
    final paint = Paint()..colorFilter = ColorFilter.mode(color, BlendMode.srcIn);
    colorCanvas.drawImage(baseImage, ui.Offset.zero, paint);
    final ui.Image image = await colorRecorder.endRecording().toImage(baseImage.width, baseImage.height);

    // 5. Convert Image → PNG bytes
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData == null) {
      throw Exception("Failed to convert SVG to PNG");
    }
    log("byteData: ${byteData.buffer.asUint8List()}");
    return byteData.buffer.asUint8List();
  }
}
