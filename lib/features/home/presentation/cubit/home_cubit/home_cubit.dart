import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/location_manager/location_service.dart';

import '../../../data/models/category_model.dart';
import '../../../data/models/city_model.dart';
import '../../../data/repos/home_repo/home_repo.dart';

part 'home_state.dart';

class CityMatchResult {
  final CityModel city;
  final bool isFallback;

  CityMatchResult({required this.city, required this.isFallback});
}

@Injectable()
class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;
  final LocationService _locationService;

  HomeCubit(this._homeRepo, this._locationService) : super(const HomeState());

  Future<void> initHome() async {
    getCities();
    getCategories();
  }

  // ────────────────────────────────────────────────
  // CITIES
  // ────────────────────────────────────────────────
  Future<void> getCities() async {
    emit(state.copyWith(citiesState: RequestState.loading, citiesError: null));

    final result = await _homeRepo.getCities();
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            citiesState: RequestState.error,
            citiesError: failure.errorMessage,
            globalError: failure.errorMessage,
          ),
        );
      },
      (cities) {
        emit(state.copyWith(citiesState: RequestState.success, cities: cities, citiesError: null));
        loadUserLocation();
      },
    );
  }

  // ────────────────────────────────────────────────
  // CATEGORIES
  // ────────────────────────────────────────────────
  Future<void> getCategories() async {
    emit(state.copyWith(categoriesState: RequestState.loading, categoriesError: null));

    final result = await _homeRepo.getCategories();

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

  // ────────────────────────────────────────────────
  // LOCATION
  // ────────────────────────────────────────────────
  Future<void> loadUserLocation() async {
    emit(state.copyWith(locationState: RequestState.loading, locationError: null));

    try {
      final rawLocation = await _locationService.getBestEffortLocation();

      final match = _getCityForLocation(rawLocation.latitude, rawLocation.longitude, state.cities);

      double finalLat = rawLocation.latitude;
      double finalLng = rawLocation.longitude;

      if (match.isFallback) {
        finalLat = match.city.location.latitude;
        finalLng = match.city.location.longitude;
      }

      await _locationService.saveLocation(
        AppLocation(
          latitude: finalLat,
          longitude: finalLng,
          timestamp: DateTime.now(),
          cityId: match.city.id,
          cityName: match.city.name,
        ),
      );

      emit(
        state.copyWith(
          locationState: RequestState.success,
          userLatitude: finalLat,
          userLongitude: finalLng,
          currentCity: match.city,
        ),
      );
    } catch (e) {
      emit(state.copyWith(locationState: RequestState.error, locationError: e.toString()));
    }
  }

  Future<void> selectCity(CityModel city) async {
    final appLocation = AppLocation(
      latitude: city.location.latitude,
      longitude: city.location.longitude,
      timestamp: DateTime.now(),
      cityId: city.id,
      cityName: city.name,
    );

    await _locationService.saveLocation(appLocation);

    emit(
      state.copyWith(
        userLatitude: city.location.latitude,
        userLongitude: city.location.longitude,
        currentCity: city,
        locationState: RequestState.success,
        locationError: null,
      ),
    );
  }

  // ────────────────────────────────────────────────
  // NEW: CITY-BASED COUNT FILTERING
  // ────────────────────────────────────────────────

  int getSecondCategoryCountForCity(SecondCategory sc) {
    final cityId = state.currentCity?.id;

    if (cityId == null) {
      return sc.totalCount;
    }

    return sc.counts[cityId] ?? 0;
  }

  int getCategoryCountForCity(CategoryModel category) {
    int total = 0;
    for (final sc in category.secondCategory) {
      total += getSecondCategoryCountForCity(sc);
    }
    return total;
  }

  // ────────────────────────────────────────────────
  // HELPERS: city matching by user location
  // ────────────────────────────────────────────────
  CityMatchResult _getCityForLocation(double? latitude, double? longitude, List<CityModel> cities) {
    if (latitude == null || longitude == null || cities.isEmpty) {
      return CityMatchResult(city: cities.first, isFallback: true);
    }

    CityModel? bestMatch;
    double? bestDistance;

    for (final city in cities) {
      final distance = _calculateDistanceInMeters(latitude, longitude, city.location.latitude, city.location.longitude);

      final cityRadiusMeters = city.radius * 1000;

      if (distance <= cityRadiusMeters) {
        if (bestDistance == null || distance < bestDistance) {
          bestDistance = distance;
          bestMatch = city;
        }
      }
    }

    if (bestMatch != null) {
      return CityMatchResult(city: bestMatch, isFallback: false);
    }
    return CityMatchResult(city: cities.first, isFallback: true);
  }

  double _calculateDistanceInMeters(double lat1, double lon1, double lat2, double lon2) {
    const earthRadius = 6371000.0;
    final dLat = _degToRad(lat2 - lat1);
    final dLon = _degToRad(lon2 - lon1);

    final a =
        math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_degToRad(lat1)) * math.cos(_degToRad(lat2)) * math.sin(dLon / 2) * math.sin(dLon / 2);

    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadius * c;
  }

  double _degToRad(double deg) => deg * (math.pi / 180.0);

  void clearGlobalError() {
    emit(state.copyWith(globalError: null));
  }
}
