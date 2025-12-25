import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../location_service.dart';

part 'location_permission_state.dart';

@injectable
class LocationPermissionCubit extends Cubit<LocationPermissionState> {
  final LocationService _locationService;

  LocationPermissionCubit(this._locationService) : super(LocationPermissionInitial());

  /// If [forceRequest] is false => only checks current status (no OS sheet).
  /// If [forceRequest] is true  => will request permission (OS sheet if allowed).
  Future<void> requestLocation({bool forceRequest = true}) async {
    emit(LocationPermissionLoading());

    final status = forceRequest
        ? await _locationService.requestPermission()
        : await _locationService.checkPermissionStatus();

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

  AppLocation tempLocation() {
    return AppLocation(latitude: 33.5138, longitude: 36.2765, timestamp: DateTime.now());
  }
}
