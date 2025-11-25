import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../location_service.dart';

part 'location_permission_state.dart';

@injectable
class LocationPermissionCubit extends Cubit<LocationPermissionState> {
  final LocationService _locationService;

  LocationPermissionCubit(this._locationService) : super(LocationPermissionInitial());

  Future<void> requestLocation() async {
    emit(LocationPermissionLoading());

    final status = await _locationService.requestPermission();

    switch (status) {
      case AppLocationPermissionStatus.granted:
        try {
          final loc = await _locationService.getCurrentLocation();
          emit(LocationPermissionGranted(loc));
        } catch (_) {
          emit(LocationPermissionError("Failed to get location."));
        }
        break;

      case AppLocationPermissionStatus.denied:
        final fallback = tempLocation();
        await _locationService.saveFallbackLocation(fallback);
        emit(LocationPermissionDenied(fallback));
        break;

      case AppLocationPermissionStatus.deniedForever:
        final fallback = tempLocation();
        await _locationService.saveFallbackLocation(fallback);
        emit(LocationPermissionForeverDenied(fallback));
        break;

      case AppLocationPermissionStatus.serviceDisabled:
        final fallback = tempLocation();
        await _locationService.saveFallbackLocation(fallback);
        emit(LocationPermissionServiceDisabled(fallback));
        break;
    }
  }

  /// Returns Damascus center as fallback.
  AppLocation tempLocation() {
    return AppLocation(latitude: 33.5138, longitude: 36.2765, timestamp: DateTime.now());
  }
}
