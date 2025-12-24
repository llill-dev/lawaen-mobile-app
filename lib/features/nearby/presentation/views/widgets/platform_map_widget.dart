import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:apple_maps_flutter/apple_maps_flutter.dart' as apple;
import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart' as gm_cluster;

import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/home/data/models/category_details_model.dart';
import 'package:lawaen/features/nearby/presentation/cubit/map_marker/map_marker_cubit.dart';
import 'package:lawaen/features/nearby/presentation/views/widgets/map_cluster_items_bottom_sheet.dart';
import 'map_itme_detail_bottom_sheet.dart';

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
  late final gm_cluster.ClusterManager<_MapClusterItem> _clusterManager;

  GoogleMapController? _googleMapController;
  Set<Marker> _googleMarkers = {};

  @override
  void initState() {
    super.initState();

    _clusterManager = gm_cluster.ClusterManager<_MapClusterItem>(
      _createClusterItems(widget.items),
      _updateMarkers,
      markerBuilder: _markerBuilder,
      stopClusteringZoom: 14,
    );
  }

  @override
  void didUpdateWidget(covariant PlatformMapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.items != widget.items) {
      _clusterManager.setItems(_createClusterItems(widget.items));
      _clusterManager.updateMap();
    }
    _moveCameraToResults(widget.items);
  }

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }

  // =====================================================
  // HELPERS
  // =====================================================

  LatLngBounds? _calculateBounds(List<CategoryDetailsModel> items) {
    final points = items
        .where((e) => e.location?.latitude != null && e.location?.longitude != null)
        .map((e) => LatLng(e.location!.latitude!, e.location!.longitude!))
        .toList();

    if (points.isEmpty) return null;

    double south = points.first.latitude;
    double north = points.first.latitude;
    double west = points.first.longitude;
    double east = points.first.longitude;

    for (final p in points) {
      south = math.min(south, p.latitude);
      north = math.max(north, p.latitude);
      west = math.min(west, p.longitude);
      east = math.max(east, p.longitude);
    }

    return LatLngBounds(southwest: LatLng(south, west), northeast: LatLng(north, east));
  }

  List<_MapClusterItem> _createClusterItems(List<CategoryDetailsModel> items) {
    return items
        .where((item) => item.location != null && item.location!.latitude != null && item.location!.longitude != null)
        .map((item) => _MapClusterItem(item))
        .toList();
  }

  void _updateMarkers(Set<Marker> markers) {
    if (!mounted) return;
    setState(() {
      _googleMarkers = markers;
    });
  }

  bool get _markersReady {
    final state = context.read<MapMarkerCubit>().state;
    return state.fallbackGoogle != null && state.fallbackApple != null;
  }

  void _moveCameraToResults(List<CategoryDetailsModel> items) {
    if (_googleMapController == null) return;
    if (items.isEmpty) return;

    final bounds = _calculateBounds(items);
    if (bounds == null) return;

    _googleMapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 10));
  }

  // =====================================================
  // WIDGET BUILD
  // =====================================================
  @override
  Widget build(BuildContext context) {
    if (widget.latitude == null || widget.longitude == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return BlocBuilder<MapMarkerCubit, MapMarkerState>(
      builder: (context, state) {
        // WAIT until fallback icons are loaded
        if (!_markersReady) {
          return const SizedBox();
        }

        return _buildMapContent(context, state);
      },
    );
  }

  // =====================================================
  // MAP CONTENT
  // =====================================================
  Widget _buildMapContent(BuildContext context, MapMarkerState state) {
    final appleMarkerCache = state.markersApple;
    final fallbackApple = state.fallbackApple!;

    // GOOGLE MAPS
    if (!Platform.isIOS) {
      return GoogleMap(
        initialCameraPosition: CameraPosition(target: LatLng(widget.latitude!, widget.longitude!), zoom: 15),
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

    // APPLE MAPS
    return apple.AppleMap(
      initialCameraPosition: apple.CameraPosition(target: apple.LatLng(widget.latitude!, widget.longitude!), zoom: 15),
      myLocationEnabled: true,
      annotations: _buildAppleMarkers(context, appleMarkerCache, fallbackApple),
    );
  }

  // =====================================================
  // GOOGLE MARKER BUILDER (Cluster + Single)
  // =====================================================
  Future<Marker> _markerBuilder(gm_cluster.Cluster<_MapClusterItem> cluster) async {
    final state = context.read<MapMarkerCubit>().state;

    // CLUSTER MARKER
    if (cluster.isMultiple) {
      final icon = await _createClusterIcon(size: 120, text: cluster.count.toString());

      return Marker(
        markerId: MarkerId("cluster_${cluster.getId()}"),
        position: cluster.location,
        icon: icon,
        onTap: () async {
          if (_googleMapController != null) {
            final zoom = await _googleMapController!.getZoomLevel();
            _googleMapController!.animateCamera(
              CameraUpdate.newCameraPosition(CameraPosition(target: cluster.location, zoom: zoom + 1)),
            );
          }

          final items = cluster.items.map((e) => e.item).toList();

          if (mounted) {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              builder: (_) => MapClusterItemsBottomSheet(items: items),
            );
          }
        },
      );
    }

    // SINGLE MARKER
    final item = cluster.items.first.item;
    final markerIcon = state.markersGoogle[item.mainCategoryId] ?? state.fallbackGoogle!;

    return Marker(
      markerId: MarkerId(item.id),
      position: LatLng(item.location!.latitude!, item.location!.longitude!),
      icon: markerIcon,
      onTap: () => _openItemDetails(context, item),
    );
  }

  // =====================================================
  // CLUSTER ICON GENERATOR
  // =====================================================
  Future<BitmapDescriptor> _createClusterIcon({required int size, required String text}) async {
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);

    final center = Offset(size / 2, size / 2);
    final paint = Paint()..color = ColorManager.primary;

    // Background circle
    canvas.drawCircle(center, size / 2.0, paint);

    // Text
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

  // =====================================================
  // APPLE MARKERS
  // =====================================================
  Set<apple.Annotation> _buildAppleMarkers(
    BuildContext context,
    Map<String, apple.BitmapDescriptor> appleCache,
    apple.BitmapDescriptor fallbackApple,
  ) {
    return widget.items
        .where((item) => item.location != null && item.location!.latitude != null && item.location!.longitude != null)
        .map((item) {
          final icon = appleCache[item.mainCategoryId] ?? fallbackApple;

          return apple.Annotation(
            annotationId: apple.AnnotationId(item.id),
            position: apple.LatLng(item.location!.latitude!, item.location!.longitude!),
            onTap: () => _openItemDetails(context, item),
            icon: icon,
          );
        })
        .toSet();
  }

  // =====================================================
  // OPEN ITEM DETAIL
  // =====================================================
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
      backgroundColor: ColorManager.primary,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => MapItemDetailBottomSheet(item: item),
    );
  }
}
