import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:apple_maps_flutter/apple_maps_flutter.dart' as apple;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lawaen/app/core/widgets/loading_widget.dart';
import 'package:lawaen/app/core/widgets/primary_button.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/location_manager/location_service.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

@RoutePage()
class MapPickerScreen extends StatefulWidget {
  final double? initialLatitude;
  final double? initialLongitude;

  const MapPickerScreen({super.key, this.initialLatitude, this.initialLongitude});

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  double? _lat;
  double? _lng;
  bool _loading = true;

  late final LocationService _locationService;

  @override
  void initState() {
    super.initState();
    _locationService = getIt<LocationService>();
    _initLocation();
  }

  Future<void> _initLocation() async {
    try {
      if (widget.initialLatitude != null && widget.initialLongitude != null) {
        _lat = widget.initialLatitude;
        _lng = widget.initialLongitude;
      } else {
        final loc = await _locationService.getBestEffortLocation();
        _lat = loc.latitude;
        _lng = loc.longitude;
      }
    } catch (_) {
      // fallback in case of any error
      final fallback = await _locationService.getBestEffortLocation();
      _lat = fallback.latitude;
      _lng = fallback.longitude;
    }

    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  void _onConfirm() {
    if (_lat == null || _lng == null) return;
    context.router.pop({'lat': _lat!, 'lng': _lng!});
  }

  @override
  Widget build(BuildContext context) {
    if (_loading || _lat == null || _lng == null) {
      return const Scaffold(body: Center(child: LoadingWidget()));
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(child: _buildPlatformMap()),
            Positioned(
              left: 16.w,
              right: 16.w,
              bottom: 16.h,
              child: PrimaryButton(text: LocaleKeys.confirmLocation.tr(), onPressed: _onConfirm, withShadow: true),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformMap() {
    if (Platform.isIOS) {
      return apple.AppleMap(
        initialCameraPosition: apple.CameraPosition(target: apple.LatLng(_lat!, _lng!), zoom: 15),
        myLocationEnabled: true,
        annotations: {
          apple.Annotation(
            annotationId: apple.AnnotationId('selected'),
            position: apple.LatLng(_lat!, _lng!),
            draggable: true,
            onDragEnd: (pos) {
              setState(() {
                _lat = pos.latitude;
                _lng = pos.longitude;
              });
            },
          ),
        },
        onTap: (apple.LatLng pos) {
          setState(() {
            _lat = pos.latitude;
            _lng = pos.longitude;
          });
        },
      );
    }

    // ANDROID – Google Maps
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: LatLng(_lat!, _lng!), zoom: 15),
      myLocationEnabled: true,
      markers: {
        Marker(
          markerId: const MarkerId('selected'),
          position: LatLng(_lat!, _lng!),
          draggable: true,
          onDragEnd: (pos) {
            setState(() {
              _lat = pos.latitude;
              _lng = pos.longitude;
            });
          },
        ),
      },
      onTap: (pos) {
        setState(() {
          _lat = pos.latitude;
          _lng = pos.longitude;
        });
      },
    );
  }
}
