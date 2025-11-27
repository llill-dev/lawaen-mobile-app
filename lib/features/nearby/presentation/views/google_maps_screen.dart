import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsScreen extends StatelessWidget {
  const GoogleMapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(initialCameraPosition: const CameraPosition(target: LatLng(33.5138, 36.2765), zoom: 12)),
    );
  }
}
