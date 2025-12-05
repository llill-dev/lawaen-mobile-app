import 'dart:io';
import 'dart:ui' as ui;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:apple_maps_flutter/apple_maps_flutter.dart' as apple;
import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart' as gm_cluster;

import 'package:lawaen/app/core/widgets/loading_widget.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/home/data/models/category_details_model.dart';
import 'package:lawaen/features/nearby/presentation/views/widgets/map_itme_detail_bottom_sheet.dart';

import 'marker_helper.dart';

/// Cluster item wrapper
class _MapClusterItem with gm_cluster.ClusterItem {
  final CategoryDetailsModel item;

  _MapClusterItem(this.item);

  @override
  LatLng get location => LatLng(item.location!.latitude!, item.location!.longitude!);
}

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

  late final gm_cluster.ClusterManager<_MapClusterItem> _clusterManager;
  Set<Marker> _googleMarkers = {};
  GoogleMapController? _googleMapController;

  @override
  void initState() {
    super.initState();

    _clusterManager = gm_cluster.ClusterManager<_MapClusterItem>(
      _createClusterItems(widget.items),
      _updateMarkers,
      markerBuilder: _markerBuilder,
      stopClusteringZoom: 20,
      // maxItemsForMaxDistAlgo: 5,
    );

    _loadMarkers();
  }

  @override
  void didUpdateWidget(covariant PlatformMapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.items != widget.items) {
      _clusterManager.setItems(_createClusterItems(widget.items));
      _clusterManager.updateMap();
    }
  }

  Future<void> _loadMarkers() async {
    googleMarker = await MarkerHelper.loadGoogleMarker(ImageManager.marker);
    appleMarker = await MarkerHelper.loadAppleMarker(ImageManager.marker);
    setState(() {});
  }

  List<_MapClusterItem> _createClusterItems(List<CategoryDetailsModel> items) {
    return items
        .where((item) => item.location != null && item.location!.latitude != null && item.location!.longitude != null)
        .map((item) => _MapClusterItem(item))
        .toList();
  }

  void _updateMarkers(Set<Marker> markers) {
    setState(() {
      _googleMarkers = markers;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.latitude == null || widget.longitude == null) {
      return const LoadingWidget();
    }

    // === GOOGLE MAPS ===
    if (!Platform.isIOS) {
      return GoogleMap(
        initialCameraPosition: CameraPosition(target: LatLng(widget.latitude!, widget.longitude!), zoom: 12),
        myLocationEnabled: true,
        markers: _googleMarkers,
        onMapCreated: (controller) {
          _googleMapController = controller;
          _clusterManager.setMapId(controller.mapId);
          _clusterManager.updateMap();
        },
        onCameraMove: _clusterManager.onCameraMove,
        onCameraIdle: _clusterManager.updateMap,
      );
    }

    // === APPLE MAPS ===
    return apple.AppleMap(
      initialCameraPosition: apple.CameraPosition(target: apple.LatLng(widget.latitude!, widget.longitude!), zoom: 12),
      myLocationEnabled: true,
      annotations: _buildAppleMarkers(context),
    );
  }

  // ==========================================================
  // MARKER BUILDER (cluster or single)
  // ==========================================================
  Future<Marker> _markerBuilder(gm_cluster.Cluster<_MapClusterItem> cluster) async {
    // ===== CLUSTER (MULTIPLE ITEMS) =====
    if (cluster.isMultiple) {
      final icon = await _createClusterIcon(size: 120, text: cluster.count.toString());

      return Marker(
        markerId: MarkerId("cluster_${cluster.getId()}"),
        position: cluster.location,
        icon: icon,
        onTap: () async {
          if (_googleMapController == null) return;
          final zoom = await _googleMapController!.getZoomLevel();

          _googleMapController!.animateCamera(
            CameraUpdate.newCameraPosition(CameraPosition(target: cluster.location, zoom: zoom + 2)),
          );
        },
      );
    }

    // ===== SINGLE MARKER =====
    final item = cluster.items.first.item;

    final markerIcon = googleMarker ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);

    return Marker(
      markerId: MarkerId(item.id),
      position: LatLng(item.location!.latitude!, item.location!.longitude!),
      icon: markerIcon,
      onTap: () => _openItemDetails(context, item),
    );
  }

  // ==========================================================
  // SIMPLE BLUE CIRCLE CLUSTER ICON
  // ==========================================================
  Future<BitmapDescriptor> _createClusterIcon({required int size, required String text}) async {
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);

    final center = ui.Offset(size / 2, size / 2);
    final paint = ui.Paint()..color = ColorManager.primary;

    canvas.drawCircle(center, size / 2.0, paint);

    final textPainter = TextPainter(textDirection: ui.TextDirection.ltr);
    textPainter.text = TextSpan(
      text: text,
      style: TextStyle(fontSize: size / 3, color: Colors.white, fontWeight: FontWeight.bold),
    );

    textPainter.layout();
    textPainter.paint(canvas, Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 2));

    final img = await recorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }

  // ==========================================================
  // APPLE MARKERS
  // ==========================================================
  Set<apple.Annotation> _buildAppleMarkers(BuildContext context) {
    if (appleMarker == null) return {};

    return widget.items
        .where((item) => item.location != null && item.location!.latitude != null && item.location!.longitude != null)
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

  Future<String?> _openItemDetails(BuildContext context, CategoryDetailsModel item) async {
    final hasNoData =
        (item.name == null || item.name!.isEmpty) &&
        (item.image == null || item.image!.isEmpty) &&
        (item.location?.address == null || item.location!.address!.isEmpty);

    if (hasNoData) {
      context.router.push(CategoryItemDetialsRoute(subCategoryId: item.main!, itemId: item.id));
      return null;
    }

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: ColorManager.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (_) {
        return MapItemDetailBottomSheet(item: item);
      },
    );
  }
}
