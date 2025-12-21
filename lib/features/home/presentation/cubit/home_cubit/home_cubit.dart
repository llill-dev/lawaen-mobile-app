import 'dart:developer';
import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/app_prefs.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/external/models/weather_model.dart';
import 'package:lawaen/app/external/params/get_weather_params.dart';
import 'package:lawaen/app/location_manager/location_service.dart';
import 'package:lawaen/features/events/data/models/event_model.dart';
import 'package:lawaen/features/events/presentation/params/get_events_params.dart';
import 'package:lawaen/features/home/data/models/banner_model.dart';
import 'package:lawaen/features/home/data/models/category_details_model.dart';
import 'package:lawaen/features/home/data/models/contact_model.dart';
import 'package:lawaen/features/home/presentation/params/get_category_details_params.dart';
import 'package:lawaen/features/home/presentation/params/register_fcm_token_params.dart';

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
    getCategories();
    getCities();
    getContact();
    getBanners();
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
      (cities) async {
        emit(state.copyWith(citiesState: RequestState.success, cities: cities, citiesError: null));
        await _loadUserLocation();
        await getHomeEvents();
        await getHomeData();
        await getWeather();
        await _tryRegisterFcmToken();
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
  // EVENTS
  // ────────────────────────────────────────────────
  Future<void> getHomeEvents() async {
    if (state.currentCity == null) {
      return;
    }

    emit(state.copyWith(evetnsState: RequestState.loading, eventsError: null));

    final result = await _homeRepo.getHomeEvents(GetEventsParams(city: state.currentCity!.id));

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            evetnsState: RequestState.error,
            eventsError: failure.errorMessage,
            globalError: failure.errorMessage,
          ),
        );
      },
      (events) {
        emit(state.copyWith(evetnsState: RequestState.success, events: events, eventsError: null));
      },
    );
  }

  // ────────────────────────────────────────────────
  // CATEGORY DETAILS
  // ────────────────────────────────────────────────
  Future<void> getHomeData({bool isLoadMore = false}) async {
    if (state.currentCity == null) return;

    if (isLoadMore) {
      if (!state.homeDataHasMore || state.isLoadMore) return;
      emit(state.copyWith(isLoadMore: true));
    } else {
      emit(
        state.copyWith(
          categoryDetailsState: RequestState.loading,
          categoryDetailsError: null,
          globalError: null,
          categoryDetails: [],
          isLoadMore: false,
          homeDataCurrentPage: 1,
          homeDataHasMore: true,
        ),
      );
    }

    final location = await _locationService.getBestEffortLocation();

    final params = GetCategoryDetailsParams(
      cityId: state.currentCity?.id ?? location.cityId ?? "",
      latitude: state.userLatitude ?? location.latitude,
      longitude: state.userLongitude ?? location.longitude,
      limit: state.homeDataLimit,
      page: state.homeDataCurrentPage,
    );

    final result = await _homeRepo.getHomeData(params);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            categoryDetailsState: RequestState.error,
            categoryDetailsError: failure.errorMessage,
            globalError: failure.errorMessage,
            isLoadMore: false,
          ),
        );
      },
      (newItems) {
        final updatedList = isLoadMore ? [...state.categoryDetails, ...newItems] : newItems;

        emit(
          state.copyWith(
            categoryDetailsState: RequestState.success,
            categoryDetails: updatedList,
            categoryDetailsError: null,
            isLoadMore: false,
            homeDataCurrentPage: newItems.isEmpty ? state.homeDataCurrentPage : state.homeDataCurrentPage + 1,
            homeDataHasMore: newItems.isNotEmpty,
          ),
        );
      },
    );
  }

  // ────────────────────────────────────────────────
  // CONTACT
  // ────────────────────────────────────────────────
  Future<void> getContact() async {
    emit(state.copyWith(contactState: RequestState.loading, contactError: null));

    final result = await _homeRepo.getContact();

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            contactState: RequestState.error,
            contactError: failure.errorMessage,
            globalError: failure.errorMessage,
          ),
        );
      },
      (contact) {
        emit(state.copyWith(contactState: RequestState.success, contact: contact, contactError: null));
      },
    );
  }

  // ────────────────────────────────────────────────
  // WEATHER
  // ────────────────────────────────────────────────
  Future<void> getWeather() async {
    if (state.userLatitude == null || state.userLongitude == null) return;

    emit(state.copyWith(weatherState: RequestState.loading, weatherError: null));

    final params = GetWeatherParams(latitude: state.userLatitude!, longitude: state.userLongitude!);

    final result = await _homeRepo.getWeather(params);

    result.fold(
      (error) {
        emit(state.copyWith(weatherState: RequestState.error, weatherError: error.message));
      },
      (weather) {
        emit(state.copyWith(weatherState: RequestState.success, weather: weather, weatherError: null));
      },
    );
  }

  // ────────────────────────────────────────────────
  // BANNERS
  // ────────────────────────────────────────────────
  Future<void> getBanners() async {
    emit(state.copyWith(bannersState: RequestState.loading, bannersError: null));

    final result = await _homeRepo.getBanners();

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            bannersState: RequestState.error,
            bannersError: failure.errorMessage,
            globalError: failure.errorMessage,
          ),
        );
      },
      (banners) {
        final homeBanners = banners.where((banner) => banner.inhome == true).toList();
        final otherBanners = banners.where((banner) => banner.inhome != true).toList();

        emit(
          state.copyWith(
            bannersState: RequestState.success,
            homeBanners: homeBanners,
            otherBanners: otherBanners,
            bannersError: null,
          ),
        );
      },
    );
  }

  // ────────────────────────────────────────────────
  // LOCATION
  // ────────────────────────────────────────────────
  Future<void> _loadUserLocation() async {
    emit(state.copyWith(locationState: RequestState.loading, locationError: null));

    try {
      final rawLocation = await _locationService.getBestEffortLocation();

      final match = _getCityForLocation(rawLocation.latitude, rawLocation.longitude, state.cities);

      double finalLat = rawLocation.latitude;
      double finalLng = rawLocation.longitude;
      // double finalLat = match.city.location.latitude;
      // double finalLng = match.city.location.longitude;

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

    initHome();
  }

  Future<void> _tryRegisterFcmToken() async {
    final prefs = getIt<AppPreferences>();
    if (prefs.isGuest) return;

    if (prefs.isFcmRegistered) return;

    if (state.currentCity == null) return;

    final String fcmToken = prefs.fcmToken;
    if (fcmToken.isEmpty) return;

    final lat = state.userLatitude?.toString() ?? "";
    final lng = state.userLongitude?.toString() ?? "";
    final cityId = state.currentCity!.id;

    final params = RegisterFcmTokenParams(fcmToken: fcmToken, latitude: lat, longitude: lng, cityId: cityId);

    final result = await _homeRepo.registerFcmToken(params);

    result.fold(
      (error) {
        // ❌ API failed → do NOT save flag, allow retry next launch
        log("FCM register error: ${error.errorMessage}");
      },
      (successModel) async {
        // ✅ API success → save flag
        await prefs.setFcmRegistered(true);
        log("FCM Token Registered Successfully!");
      },
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
