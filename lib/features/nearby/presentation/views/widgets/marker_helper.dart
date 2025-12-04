import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:apple_maps_flutter/apple_maps_flutter.dart' as apple;

class MarkerHelper {
  /// Loads an image from assets and converts it into a BitmapDescriptor.
  static Future<BitmapDescriptor> loadGoogleMarker(String assetPath, {double size = 40}) async {
    final byteData = await rootBundle.load(assetPath);
    return BitmapDescriptor.bytes(byteData.buffer.asUint8List(), height: size, width: size);
  }

  static Future<apple.BitmapDescriptor> loadAppleMarker(String assetPath, {int size = 80}) async {
    final byteData = await rootBundle.load(assetPath);
    return apple.BitmapDescriptor.fromBytes(byteData.buffer.asUint8List());
  }
}
