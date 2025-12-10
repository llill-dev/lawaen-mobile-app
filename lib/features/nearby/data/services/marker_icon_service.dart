import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:apple_maps_flutter/apple_maps_flutter.dart' as apple;
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';

@lazySingleton
class MarkerIconService {
  final Dio _dio;

  MarkerIconService(this._dio);

  final String fallBackMarker = ImageManager.marker;

  final Map<String, BitmapDescriptor> googleCache = {};
  final Map<String, apple.BitmapDescriptor> appleCache = {};

  // Medium marker size (circle size in px)
  static const int _markerSize = 80;
  static const double _iconScale = 0.6; // icon size relative to circle

  late final Future<BitmapDescriptor> googleFallback = _loadFallbackGoogle();
  late final Future<apple.BitmapDescriptor> appleFallback = _loadFallbackApple();

  // ---------------------------------------------------------------------------
  // FALLBACK LOADING
  // ---------------------------------------------------------------------------

  Future<BitmapDescriptor> _loadFallbackGoogle() async {
    // Load asset bytes
    final data = await rootBundle.load(fallBackMarker);
    final wrapped = await _wrapWithCircleBackground(
      data.buffer.asUint8List(),
      size: _markerSize,
      iconScale: _iconScale,
    );
    return BitmapDescriptor.fromBytes(wrapped);
  }

  Future<apple.BitmapDescriptor> _loadFallbackApple() async {
    final data = await rootBundle.load(fallBackMarker);
    final wrapped = await _wrapWithCircleBackground(
      data.buffer.asUint8List(),
      size: _markerSize,
      iconScale: _iconScale,
    );
    return apple.BitmapDescriptor.fromBytes(wrapped);
  }

  // ---------------------------------------------------------------------------
  // MARKER BYTES DOWNLOAD (WITH ERROR HANDLING)
  // ---------------------------------------------------------------------------

  Future<Uint8List> _safeDownload(String url) async {
    try {
      final response = await _dio.get<List<int>>(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          sendTimeout: const Duration(seconds: 8),
          receiveTimeout: const Duration(seconds: 8),
        ),
      );

      if (response.data == null || response.data!.isEmpty) {
        throw Exception("Empty marker bytes");
      }

      return Uint8List.fromList(response.data!);
    } catch (e) {
      log("❌ Marker download failed → $url → $e");
      rethrow;
    }
  }

  // ---------------------------------------------------------------------------
  // OPTIONAL: RESIZE PNG BYTES (ONLY IF YOU WANT BIGGER/SCALED MARKERS)
  // ---------------------------------------------------------------------------

  Future<Uint8List> _resizeBytes(Uint8List bytes, {required int targetWidth}) async {
    final codec = await ui.instantiateImageCodec(bytes, targetWidth: targetWidth);
    final frame = await codec.getNextFrame();
    final image = frame.image;

    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  // ---------------------------------------------------------------------------
  // CIRCLE + ICON COMPOSITOR
  // ---------------------------------------------------------------------------

  Future<Uint8List> _wrapWithCircleBackground(
    Uint8List iconBytes, {
    required int size,
    required double iconScale,
  }) async {
    // Decode original icon
    final codec = await ui.instantiateImageCodec(iconBytes);
    final frame = await codec.getNextFrame();
    final ui.Image iconImage = frame.image;

    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);

    final double s = size.toDouble();
    final center = Offset(s / 2, s / 2);

    // Draw circle background
    final bgPaint = Paint()..color = ColorManager.primary;
    canvas.drawCircle(center, s / 2, bgPaint);

    // Calculate destination rect for icon
    final double iconSize = s * iconScale;
    final dst = Rect.fromLTWH((s - iconSize) / 2, (s - iconSize) / 2, iconSize, iconSize);

    final src = Rect.fromLTWH(0, 0, iconImage.width.toDouble(), iconImage.height.toDouble());

    // Draw icon into circle
    canvas.drawImageRect(iconImage, src, dst, Paint());

    final ui.Image finalImage = await recorder.endRecording().toImage(size, size);
    final byteData = await finalImage.toByteData(format: ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }

  // ---------------------------------------------------------------------------
  // GOOGLE MARKER LOADER
  // ---------------------------------------------------------------------------

  Future<BitmapDescriptor> loadGoogleMarker(String id, String url, {int targetWidth = _markerSize}) async {
    if (googleCache.containsKey(id)) {
      return googleCache[id]!;
    }

    try {
      Uint8List bytes = await _safeDownload(url);

      // Resize to base size
      bytes = await _resizeBytes(bytes, targetWidth: targetWidth);

      // Wrap with circular background
      final wrapped = await _wrapWithCircleBackground(bytes, size: targetWidth, iconScale: _iconScale);

      final marker = BitmapDescriptor.fromBytes(wrapped);
      googleCache[id] = marker;
      return marker;
    } catch (_) {
      final fallback = await googleFallback;
      googleCache[id] = fallback;
      return fallback;
    }
  }

  // ---------------------------------------------------------------------------
  // APPLE MARKER LOADER
  // ---------------------------------------------------------------------------

  Future<apple.BitmapDescriptor> loadAppleMarker(String id, String url, {int targetWidth = _markerSize}) async {
    if (appleCache.containsKey(id)) {
      return appleCache[id]!;
    }

    try {
      Uint8List bytes = await _safeDownload(url);

      // Resize to base size
      bytes = await _resizeBytes(bytes, targetWidth: targetWidth);

      // Wrap with circular background
      final wrapped = await _wrapWithCircleBackground(bytes, size: targetWidth, iconScale: _iconScale);

      final marker = apple.BitmapDescriptor.fromBytes(wrapped);
      appleCache[id] = marker;
      return marker;
    } catch (_) {
      final fallback = await appleFallback;
      appleCache[id] = fallback;
      return fallback;
    }
  }
}
