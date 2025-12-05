import 'dart:developer';
import 'dart:math' as math;

import 'package:apple_maps_flutter/apple_maps_flutter.dart' as apple;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/services/category_lookup_service.dart';
import 'package:lawaen/app/core/services/marker_icon_service.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/location_manager/location_service.dart';
import 'package:lawaen/features/home/data/models/category_details_model.dart';
import 'package:lawaen/features/home/data/models/category_model.dart';
import 'package:lawaen/features/home/presentation/params/get_category_details_params.dart';
import 'package:lawaen/features/nearby/data/repos/map_repo.dart';

part 'map_state.dart';

@Injectable()
class MapCubit extends Cubit<MapState> {
  final MapRepo _mapRepo;
  final CategoryLookupService _categoryLookupService;
  final MarkerIconService _markerIconService;
  final LocationService _locationService;

  String? _search;

  MapCubit(this._mapRepo, this._locationService, this._categoryLookupService, this._markerIconService)
    : super(const MapState());

  // ===================================================
  // INIT MAP
  // ===================================================
  Future<void> initMap() async {
    emit(state.copyWith(itemsState: RequestState.loading));

    final location = await _locationService.getBestEffortLocation();

    emit(state.copyWith(userLatitude: location.latitude, userLongitude: location.longitude));

    await _loadInitialItems();
  }

  Future<void> _loadInitialItems() async {
    if (state.userLatitude == null || state.userLongitude == null) return;

    emit(state.copyWith(itemsState: RequestState.loading));

    final params = GetCategoryDetailsParams(
      latitude: state.userLatitude!,
      longitude: state.userLongitude!,
      limit: 15,
      page: 1,
      search: _search,
    );

    final result = await _mapRepo.getInitialItems(params);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            itemsState: RequestState.error,
            itemsError: failure.errorMessage,
            globalError: failure.errorMessage,
          ),
        );
      },
      (items) {
        final updated = _attachTravelTimes(items);
        emit(state.copyWith(itemsState: RequestState.success, items: updated, itemsError: null));
      },
    );
  }

  // ===================================================
  // FILTER BY CATEGORY
  // ===================================================
  Future<void> selectCategory(String? categoryId) async {
    emit(state.copyWith(selectedCategoryId: categoryId));

    if (categoryId == null) {
      await _loadInitialItems();
      return;
    }

    await _loadItemsByCategory(categoryId);
  }

  Future<void> _loadItemsByCategory(String categoryId) async {
    emit(state.copyWith(itemsState: RequestState.loading));

    final params = GetCategoryDetailsParams(
      latitude: state.userLatitude!,
      longitude: state.userLongitude!,
      limit: 25,
      page: 1,
      search: _search,
    );

    final result = await _mapRepo.getItemsByCategory(categoryId, params);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            itemsState: RequestState.error,
            itemsError: failure.errorMessage,
            globalError: failure.errorMessage,
          ),
        );
      },
      (items) {
        final updated = _attachTravelTimes(items);
        emit(state.copyWith(itemsState: RequestState.success, items: updated, itemsError: null));
        //_ensureIconsForItems(items);
      },
    );
  }

  // ===================================================
  // LOAD CATEGORIES
  // ===================================================
  Future<void> _loadCategories() async {
    emit(state.copyWith(categoriesState: RequestState.loading));

    final result = await _mapRepo.getCategories();

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            categoriesState: RequestState.error,
            categoriesError: failure.errorMessage,
            globalError: failure.errorMessage,
          ),
        );
      },
      (categories) {
        //_categoryLookupService.load(categories);
        emit(state.copyWith(categoriesState: RequestState.success, categories: categories, categoriesError: null));
        //_ensureIconsForItems(state.items);
      },
    );
  }

  // ===================================================
  // SEARCH FILTER
  // ===================================================
  Future<void> updateSearch(String text) async {
    _search = text;

    await _loadInitialItems();
  }

  Future<void> expandSheet(bool expanded) async {
    emit(state.copyWith(isSheetExpanded: expanded));

    if (expanded && state.categories.isEmpty) {
      await _loadCategories();
    }
  }

  // ===================================================
  // Travel Times helper
  // ===================================================
  List<CategoryDetailsModel> _attachTravelTimes(List<CategoryDetailsModel> items) {
    final userLat = state.userLatitude;
    final userLng = state.userLongitude;

    if (userLat == null || userLng == null) return items;

    return items.map((item) {
      final lat = item.location?.latitude;
      final lng = item.location?.longitude;

      double? time;

      if (lat != null && lng != null) {
        time = _estimateTravelMinutes(userLat: userLat, userLng: userLng, itemLat: lat, itemLng: lng);
      }

      return item.copyWith(travelMinutes: time);
    }).toList();
  }

  double _estimateTravelMinutes({
    required double userLat,
    required double userLng,
    required double itemLat,
    required double itemLng,
    double speedKmH = 40,
  }) {
    const earthRadius = 6371000.0;

    double degToRad(double deg) => deg * math.pi / 180.0;

    final dLat = degToRad(itemLat - userLat);
    final dLon = degToRad(itemLng - userLng);

    final a =
        math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(degToRad(userLat)) * math.cos(degToRad(itemLat)) * math.sin(dLon / 2) * math.sin(dLon / 2);

    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    final distanceMeters = earthRadius * c;

    final speedMps = speedKmH * 1000 / 3600;

    return (distanceMeters / speedMps) / 60;
  }

  Future<void> _ensureIconsForItems(List<CategoryDetailsModel> items) async {
    // Need categories to know SVG URLs
    if (state.categories.isEmpty) return;

    // Which subcategory IDs are used by these items?
    final neededSubCategoryIds = items.map((e) => e.main).whereType<String>().toSet();

    if (neededSubCategoryIds.isEmpty) return;

    // Copy current icon maps so we can mutate and then emit
    final googleMap = Map<String, BitmapDescriptor>.from(state.googleCategoryMarkers);
    final appleMap = Map<String, apple.BitmapDescriptor>.from(state.appleCategoryMarkers);

    bool changed = false;

    for (final subCategoryId in neededSubCategoryIds) {
      // Skip if already loaded
      if (googleMap.containsKey(subCategoryId) && appleMap.containsKey(subCategoryId)) continue;

      final iconUrl = _categoryLookupService.getSubCategoryIconUrl(subCategoryId);
      if (iconUrl == null || iconUrl.isEmpty) continue;

      try {
        final googleIcon = await _markerIconService.getGoogleIconForSubCategory(
          subCategoryId: subCategoryId,
          svgUrl: iconUrl,
          size: 40,
        );
        final appleIcon = await _markerIconService.getAppleIconForSubCategory(
          subCategoryId: subCategoryId,
          svgUrl: iconUrl,
          size: 80,
        );

        googleMap[subCategoryId] = googleIcon;
        appleMap[subCategoryId] = appleIcon;
        changed = true;
      } catch (e) {
        // If an icon fails, we just skip and fall back to default marker in UI
        // You can log e if you want
        log(e.toString());
      }
    }
    if (changed) {
      emit(state.copyWith(googleCategoryMarkers: googleMap, appleCategoryMarkers: appleMap));
    }
  }
}
