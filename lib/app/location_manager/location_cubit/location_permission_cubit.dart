import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../location_service.dart';

part 'location_permission_state.dart';

@injectable
@injectable
class LocationPermissionCubit extends Cubit<LocationPermissionState> {
  final LocationService _locationService;

  LocationPermissionCubit(this._locationService) : super(LocationPermissionInitial());

  /// Onboarding: forceRequest = true (user pressed enable)
  /// Refresh:    forceRequest = true (user pressed refresh -> enable -> request)
  /// If you want "check only", pass forceRequest = false.
  Future<void> requestLocation({required bool forceRequest}) async {
    emit(LocationPermissionLoading());

    final gate = await _locationService.ensureLocationReady(requestIfDenied: forceRequest);

    switch (gate) {
      case AppLocationGate.serviceDisabled:
        emit(LocationPermissionNeedsServiceEnabled());
        return;

      case AppLocationGate.permissionDeniedForever:
        emit(LocationPermissionNeedsAppSettings());
        return;

      case AppLocationGate.permissionDenied:
        emit(LocationPermissionNeedsPermission());
        return;

      case AppLocationGate.ready:
        try {
          final loc = await _locationService.getCurrentLocation();
          emit(LocationPermissionGranted(loc));
        } catch (_) {
          emit(LocationPermissionError("Failed to get location."));
        }
        return;
    }
  }

  Future<void> openLocationSettings() async {
    await _locationService.openLocationSettings();
  }

  Future<void> openAppSettings() async {
    await _locationService.openAppSettings();
  }

  /// Call this after returning from Settings (onResume).
  Future<void> recheckAfterSettings() async {
    await requestLocation(forceRequest: false);
  }
}
