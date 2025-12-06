import 'dart:developer';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:apple_maps_flutter/apple_maps_flutter.dart' as apple;
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/resources/assets_manager.dart';

@lazySingleton
class MarkerIconService {
  final Dio _dio;

  MarkerIconService(this._dio);

  final String fallBackMarker = ImageManager.marker;

  final Map<String, BitmapDescriptor> googleCache = {};
  final Map<String, apple.BitmapDescriptor> appleCache = {};

  late final Future<BitmapDescriptor> googleFallback = _loadFallbackGoogle();
  late final Future<apple.BitmapDescriptor> appleFallback = _loadFallbackApple();

  // ---------------------------------------------------------------------------
  // FALLBACK LOADING
  // ---------------------------------------------------------------------------

  Future<BitmapDescriptor> _loadFallbackGoogle() async {
    // adjust devicePixelRatio to control size (2.5 - 4.0 recommended)
    return BitmapDescriptor.fromAssetImage(const ImageConfiguration(devicePixelRatio: 3.0), fallBackMarker);
  }

  Future<apple.BitmapDescriptor> _loadFallbackApple() async {
    final data = await rootBundle.load(fallBackMarker);
    return apple.BitmapDescriptor.fromBytes(data.buffer.asUint8List());
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
  // GOOGLE MARKER LOADER
  // ---------------------------------------------------------------------------

  Future<BitmapDescriptor> loadGoogleMarker(String id, String url, {int targetWidth = 96}) async {
    if (googleCache.containsKey(id)) {
      return googleCache[id]!;
    }

    try {
      Uint8List bytes = await _safeDownload(url);

      // Resize only if wanted
      bytes = await _resizeBytes(bytes, targetWidth: targetWidth);

      final marker = BitmapDescriptor.fromBytes(bytes);
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

  Future<apple.BitmapDescriptor> loadAppleMarker(String id, String url, {int targetWidth = 96}) async {
    if (appleCache.containsKey(id)) {
      return appleCache[id]!;
    }

    try {
      Uint8List bytes = await _safeDownload(url);

      // Resize PNG
      bytes = await _resizeBytes(bytes, targetWidth: targetWidth);

      final marker = apple.BitmapDescriptor.fromBytes(bytes);
      appleCache[id] = marker;

      return marker;
    } catch (_) {
      final fallback = await appleFallback;
      appleCache[id] = fallback;
      return fallback;
    }
  }
}
