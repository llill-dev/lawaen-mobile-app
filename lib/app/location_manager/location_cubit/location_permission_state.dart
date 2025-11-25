part of 'location_permission_cubit.dart';

abstract class LocationPermissionState {}

class LocationPermissionInitial extends LocationPermissionState {}

class LocationPermissionLoading extends LocationPermissionState {}

class LocationPermissionGranted extends LocationPermissionState {
  final AppLocation location;
  LocationPermissionGranted(this.location);
}

class LocationPermissionDenied extends LocationPermissionState {
  final AppLocation fallback;
  LocationPermissionDenied(this.fallback);
}

class LocationPermissionForeverDenied extends LocationPermissionState {
  final AppLocation fallback;
  LocationPermissionForeverDenied(this.fallback);
}

class LocationPermissionServiceDisabled extends LocationPermissionState {
  final AppLocation fallback;
  LocationPermissionServiceDisabled(this.fallback);
}

class LocationPermissionError extends LocationPermissionState {
  final String message;
  LocationPermissionError(this.message);
}
