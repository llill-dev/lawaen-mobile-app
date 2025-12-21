import 'dart:math' as math;

import 'package:apple_maps_flutter/apple_maps_flutter.dart' as apple;
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/models/error_model.dart';
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
  final LocationService _locationService;

  MapCubit(this._mapRepo, this._locationService) : super(const MapState());

  // ===================================================
  // FILTER BY MAIN / SUB CATEGORY
  // ===================================================
  Future<void> selectMainCategory(String? mainId) async {
    if (mainId == null) {
      emit(
        state.copyWith(
          selectedMainCategoryId: null,
          selectedSubCategoryId: null,
          currentSubCategories: [],
          showApplyButton: false,
          items: [],
        ),
      );
      return;
    }

    final mainCategory = state.categories.firstWhere((c) => c.id == mainId);

    emit(
      state.copyWith(
        selectedMainCategoryId: mainId,
        selectedSubCategoryId: null,
        currentSubCategories: mainCategory.secondCategory,
        showApplyButton: true,
      ),
    );
  }

  void selectSubCategory(String? subId) {
    if (subId == null) {
      emit(state.copyWith(selectedSubCategoryId: null, showApplyButton: true));
      return;
    }

    emit(state.copyWith(selectedSubCategoryId: subId, showApplyButton: true));
  }

  Future<void> applyCategory() async {
    if (state.selectedMainCategoryId == null && state.selectedSubCategoryId == null) return;

    final location = await _locationService.getBestEffortLocation();

    emit(
      state.copyWith(
        itemsState: RequestState.loading,
        userLatitude: location.latitude,
        userLongitude: location.longitude,
        itemsError: null,
        globalError: null,
      ),
    );

    final params = GetCategoryDetailsParams(
      latitude: location.latitude,
      longitude: location.longitude,
      limit: 25,
      page: 1,
      search: null,
      cityId: location.cityId ?? "",
    );

    Either<ErrorModel, List<CategoryDetailsModel>> result;

    if (state.selectedSubCategoryId != null) {
      result = await _mapRepo.getItemsBySecondCategory(state.selectedSubCategoryId!, params);
    } else {
      result = await _mapRepo.getItemsByCategory(state.selectedMainCategoryId!, params);
    }

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
  // LOAD CATEGORIES
  // ===================================================
  Future<void> _loadCategories() async {
    emit(state.copyWith(categoriesState: RequestState.loading, categoriesError: null));

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
        emit(state.copyWith(categoriesState: RequestState.success, categories: categories, categoriesError: null));
      },
    );
  }

  // ===================================================
  // SHEET EXPANSION
  // ===================================================
  Future<void> expandSheet(bool expanded) async {
    emit(state.copyWith(isSheetExpanded: expanded));

    if (expanded && state.categories.isEmpty) {
      await _loadCategories();
    }
  }

  // ===================================================
  // TRAVEL TIME HELPER
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

  // ===================================================
  // LEGACY / OLD LOGIC (KEPT COMMENTED FOR REFERENCE)
  // ===================================================

  // /// OLD: init map and load initial items automatically
  // Future<void> initMap() async {
  //   emit(state.copyWith(itemsState: RequestState.loading));
  //
  //   final location = await _locationService.getBestEffortLocation();
  //
  //   emit(
  //     state.copyWith(
  //       userLatitude: location.latitude,
  //       userLongitude: location.longitude,
  //     ),
  //   );
  //
  //   await _loadInitialItems();
  // }
  //
  // Future<void> _loadInitialItems() async {
  //   if (state.userLatitude == null || state.userLongitude == null) return;
  //
  //   emit(state.copyWith(itemsState: RequestState.loading));
  //
  //   final params = GetCategoryDetailsParams(
  //     latitude: state.userLatitude!,
  //     longitude: state.userLongitude!,
  //     limit: 15,
  //     page: 1,
  //     search: _search,
  //   );
  //
  //   final result = await _mapRepo.getInitialItems(params);
  //
  //   result.fold(
  //     (failure) {
  //       emit(
  //         state.copyWith(
  //           itemsState: RequestState.error,
  //           itemsError: failure.errorMessage,
  //           globalError: failure.errorMessage,
  //         ),
  //       );
  //     },
  //     (items) {
  //       final updated = _attachTravelTimes(items);
  //       emit(
  //         state.copyWith(
  //           itemsState: RequestState.success,
  //           items: updated,
  //           itemsError: null,
  //         ),
  //       );
  //     },
  //   );
  // }
  //
  // /// OLD single-level category filter
  // Future<void> selectCategory(String? categoryId) async {
  //   emit(state.copyWith(selectedCategoryId: categoryId));
  //
  //   if (categoryId == null) {
  //     await _loadInitialItems();
  //     return;
  //   }
  //
  //   await _loadItemsByCategory(categoryId);
  // }
  //
  // Future<void> _loadItemsByCategory(String categoryId) async {
  //   emit(state.copyWith(itemsState: RequestState.loading));
  //
  //   final params = GetCategoryDetailsParams(
  //     latitude: state.userLatitude!,
  //     longitude: state.userLongitude!,
  //     limit: 25,
  //     page: 1,
  //     search: _search,
  //   );
  //
  //   final result = await _mapRepo.getItemsByCategory(categoryId, params);
  //
  //   result.fold(
  //     (failure) {
  //       emit(
  //         state.copyWith(
  //           itemsState: RequestState.error,
  //           itemsError: failure.errorMessage,
  //           globalError: failure.errorMessage,
  //         ),
  //       );
  //     },
  //     (items) {
  //       final updated = _attachTravelTimes(items);
  //       emit(
  //         state.copyWith(
  //           itemsState: RequestState.success,
  //           items: updated,
  //           itemsError: null,
  //         ),
  //       );
  //     },
  //   );
  // }

  // ===================================================
  // SEARCH
  // ===================================================
  // Future<void> updateSearch(String text) async {
  //   _search = text.trim().isEmpty ? null : text.trim();

  //   if (_search == null) {
  //     emit(state.copyWith(items: [], itemsState: RequestState.idle, itemsError: null, globalError: null));
  //     return;
  //   }

  //   await _searchItems();
  // }

  // Future<void> _searchItems() async {
  //   final location = await _locationService.getBestEffortLocation();

  //   emit(
  //     state.copyWith(
  //       itemsState: RequestState.loading,
  //       userLatitude: location.latitude,
  //       userLongitude: location.longitude,
  //       itemsError: null,
  //       globalError: null,
  //     ),
  //   );

  //   final params = GetCategoryDetailsParams(
  //     latitude: location.latitude,
  //     longitude: location.longitude,
  //     limit: 25,
  //     page: 1,
  //     search: _search,
  //     cityId: location.cityId ?? "",
  //   );

  //   final result = await _mapRepo.getInitialItems(params);

  //   result.fold(
  //     (failure) {
  //       emit(
  //         state.copyWith(
  //           itemsState: RequestState.error,
  //           itemsError: failure.errorMessage,
  //           globalError: failure.errorMessage,
  //         ),
  //       );
  //     },
  //     (items) {
  //       final updated = _attachTravelTimes(items);
  //       emit(state.copyWith(itemsState: RequestState.success, items: updated, itemsError: null));
  //     },
  //   );
  // }
}
