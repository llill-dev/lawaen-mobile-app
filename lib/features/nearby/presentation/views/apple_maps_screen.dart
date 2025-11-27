import 'dart:io';
import 'package:flutter/material.dart';
import 'package:apple_maps_flutter/apple_maps_flutter.dart';

class AppleMapsScreen extends StatelessWidget {
  const AppleMapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS) {
      return const Center(child: Text("Apple Maps is only supported on iOS."));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Apple Maps")),
      body: AppleMap(
        initialCameraPosition: const CameraPosition(target: LatLng(33.5138, 36.2765), zoom: 12),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
