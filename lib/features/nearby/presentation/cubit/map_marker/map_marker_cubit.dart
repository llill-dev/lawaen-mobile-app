import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/features/nearby/data/repos/map_repo.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:apple_maps_flutter/apple_maps_flutter.dart' as apple;
import 'package:lawaen/features/nearby/data/services/marker_icon_service.dart';

part 'map_marker_state.dart';

@singleton
class MapMarkerCubit extends Cubit<MapMarkerState> {
  final MapRepo _repo;
  final MarkerIconService _iconService;

  MapMarkerCubit(this._repo, this._iconService) : super(const MapMarkerState(isLoading: true)) {
    _preloadFallbacks();
  }

  // -------------------------------------------------------------
  // PRELOAD FALLBACKS EARLY
  // -------------------------------------------------------------
  Future<void> _preloadFallbacks() async {
    final google = await _iconService.googleFallback;
    final apple = await _iconService.appleFallback;

    emit(state.copyWith(fallbackGoogle: google, fallbackApple: apple));
  }

  // -------------------------------------------------------------
  // LOAD API MARKERS
  // -------------------------------------------------------------
  Future<void> loadMarkers() async {
    emit(state.copyWith(isLoading: true));

    final result = await _repo.getMapMarkers();

    await result.fold(
      (error) async {
        emit(state.copyWith(isLoading: false, error: error.errorMessage));
      },
      (list) async {
        // Load markers in parallel
        await Future.wait(
          list.map((item) async {
            await _iconService.loadGoogleMarker(item.mainCategoryId, item.markerIcon);
            await _iconService.loadAppleMarker(item.mainCategoryId, item.markerIcon);
          }),
        );

        emit(
          state.copyWith(
            isLoading: false,
            markersGoogle: Map.of(_iconService.googleCache),
            markersApple: Map.of(_iconService.appleCache),
          ),
        );
      },
    );
  }

  // -------------------------------------------------------------
  // Whether icons (fallback at least) are ready
  // -------------------------------------------------------------
  bool get markersReady => state.fallbackGoogle != null && state.fallbackApple != null;
}
