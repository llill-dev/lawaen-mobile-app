part of 'location_permission_cubit.dart';

abstract class LocationPermissionState {}

class LocationPermissionInitial extends LocationPermissionState {}

class LocationPermissionLoading extends LocationPermissionState {}

class LocationPermissionGranted extends LocationPermissionState {
  final AppLocation location;
  LocationPermissionGranted(this.location);
}

class LocationPermissionNeedsServiceEnabled extends LocationPermissionState {}

class LocationPermissionNeedsPermission extends LocationPermissionState {}

class LocationPermissionNeedsAppSettings extends LocationPermissionState {}

class LocationPermissionError extends LocationPermissionState {
  final String message;
  LocationPermissionError(this.message);
}
