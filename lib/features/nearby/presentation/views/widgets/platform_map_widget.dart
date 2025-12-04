import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:apple_maps_flutter/apple_maps_flutter.dart' as apple;
import 'package:lawaen/app/core/widgets/loading_widget.dart';

import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/home/data/models/category_details_model.dart';

import 'marker_helper.dart';

class PlatformMapWidget extends StatefulWidget {
  final double? latitude;
  final double? longitude;
  final List<CategoryDetailsModel> items;

  const PlatformMapWidget({super.key, required this.latitude, required this.longitude, required this.items});

  @override
  State<PlatformMapWidget> createState() => _PlatformMapWidgetState();
}

class _PlatformMapWidgetState extends State<PlatformMapWidget> {
  BitmapDescriptor? googleMarker;
  apple.BitmapDescriptor? appleMarker;

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  Future<void> _loadMarkers() async {
    googleMarker = await MarkerHelper.loadGoogleMarker(ImageManager.marker);
    appleMarker = await MarkerHelper.loadAppleMarker(ImageManager.marker);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.latitude == null || widget.longitude == null) {
      return const LoadingWidget();
    }

    // GOOGLE MAPS
    if (!Platform.isIOS) {
      return GoogleMap(
        initialCameraPosition: CameraPosition(target: LatLng(widget.latitude!, widget.longitude!), zoom: 12),
        myLocationEnabled: true,
        markers: _buildGoogleMarkers(context),
      );
    }

    // APPLE MAPS
    return apple.AppleMap(
      initialCameraPosition: apple.CameraPosition(target: apple.LatLng(widget.latitude!, widget.longitude!), zoom: 12),
      myLocationEnabled: true,
      annotations: _buildAppleMarkers(context),
    );
  }

  // ===========================================
  // GOOGLE MARKERS
  // ===========================================
  Set<Marker> _buildGoogleMarkers(BuildContext context) {
    if (googleMarker == null) return {};

    return widget.items
        .where((item) => item.location != null && (item.location!.latitude != null || item.location!.longitude != null))
        .map((item) {
          return Marker(
            markerId: MarkerId(item.id),

            position: LatLng(item.location!.latitude!, item.location!.longitude!),
            icon: googleMarker!,
            onTap: () => _openItemDetails(context, item),
          );
        })
        .toSet();
  }

  // ===========================================
  // APPLE MARKERS
  // ===========================================
  Set<apple.Annotation> _buildAppleMarkers(BuildContext context) {
    if (appleMarker == null) return {};

    return widget.items
        .where((item) => item.location != null && (item.location!.latitude != null || item.location!.longitude != null))
        .map((item) {
          return apple.Annotation(
            annotationId: apple.AnnotationId(item.id),
            position: apple.LatLng(item.location!.latitude!, item.location!.longitude!),
            onTap: () => _openItemDetails(context, item),
            icon: appleMarker!,
          );
        })
        .toSet();
  }

  void _openItemDetails(BuildContext context, CategoryDetailsModel item) {
    context.router.push(CategoryItemDetialsRoute(subCategoryId: item.main!, itemId: item.id));
  }
}
