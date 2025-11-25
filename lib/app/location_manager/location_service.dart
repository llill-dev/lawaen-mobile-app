import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/app_prefs.dart';

class AppLocation {
  final double latitude;
  final double longitude;
  final DateTime timestamp;

  const AppLocation({required this.latitude, required this.longitude, required this.timestamp});
}

enum AppLocationPermissionStatus { granted, denied, deniedForever, serviceDisabled }

@lazySingleton
class LocationService {
  final AppPreferences _prefs;

  LocationService(this._prefs);

  // =========================
  // Permission Handling
  // =========================

  Future<AppLocationPermissionStatus> checkPermissionStatus() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return AppLocationPermissionStatus.serviceDisabled;
    }

    final permission = await Geolocator.checkPermission();

    switch (permission) {
      case LocationPermission.always:
      case LocationPermission.whileInUse:
        return AppLocationPermissionStatus.granted;
      case LocationPermission.denied:
        return AppLocationPermissionStatus.denied;
      case LocationPermission.deniedForever:
        return AppLocationPermissionStatus.deniedForever;
      case LocationPermission.unableToDetermine:
        return AppLocationPermissionStatus.denied;
    }
  }

  /// Ask OS for permission. Should be called only after you show your own dialog in UI.
  Future<AppLocationPermissionStatus> requestPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return AppLocationPermissionStatus.serviceDisabled;
    }

    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      return AppLocationPermissionStatus.deniedForever;
    }

    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      return AppLocationPermissionStatus.granted;
    }

    return AppLocationPermissionStatus.denied;
  }

  // =========================
  // Public APIs for Location
  // =========================

  /// Get current GPS location and cache it.
  /// Throws if permission not granted or service disabled.
  Future<AppLocation> getCurrentLocation() async {
    final permissionStatus = await checkPermissionStatus();

    if (permissionStatus == AppLocationPermissionStatus.denied ||
        permissionStatus == AppLocationPermissionStatus.deniedForever ||
        permissionStatus == AppLocationPermissionStatus.serviceDisabled) {
      throw LocationException(permissionStatus);
    }
    final Position position;
    if (Platform.isIOS) {
      position = await Geolocator.getCurrentPosition(locationSettings: AppleSettings(accuracy: LocationAccuracy.high));
    } else {
      position = await Geolocator.getCurrentPosition(
        locationSettings: AndroidSettings(accuracy: LocationAccuracy.high),
      );
    }

    final location = AppLocation(latitude: position.latitude, longitude: position.longitude, timestamp: DateTime.now());

    await _saveLocation(location);
    return location;
  }

  /// Returns last cached location if available (from SharedPreferences),
  /// otherwise tries geolocator's last known position (no GPS call).
  Future<AppLocation?> getLastKnownLocation() async {
    // 1) From shared preferences
    final cached = _getLocationFromPrefs();
    if (cached != null) return cached;

    // 2) From geolocator's last known position
    final position = await Geolocator.getLastKnownPosition();
    if (position == null) return null;

    final location = AppLocation(latitude: position.latitude, longitude: position.longitude, timestamp: DateTime.now());

    await _saveLocation(location);
    return location;
  }

  /// Strategy you described: use last cached if exists (fast),
  /// then VM/UI can decide to call getCurrentLocation() for a fresh one.
  Future<AppLocation> getBestEffortLocation() async {
    final cached = _getLocationFromPrefs();
    if (cached != null) {
      return cached;
    }

    // If no cached, try to get current (might throw if no permission)
    try {
      return await getCurrentLocation();
    } catch (_) {
      return _tempLocation();
    }
  }

  Future<void> saveFallbackLocation(AppLocation location) async {
    await _saveLocation(location);
  }

  // =========================
  // Private helpers
  // =========================

  Future<void> _saveLocation(AppLocation location) async {
    await _prefs.setDouble(prefsKey: prefsLat, value: location.latitude);
    await _prefs.setDouble(prefsKey: prefsLng, value: location.longitude);
    await _prefs.setString(prefsKey: prefsLocationTimestamp, value: location.timestamp.toIso8601String());
  }

  AppLocation? _getLocationFromPrefs() {
    final lat = _prefs.getDouble(prefsKey: prefsLat);
    final lng = _prefs.getDouble(prefsKey: prefsLng);
    final tsStr = _prefs.getString(prefsKey: prefsLocationTimestamp);

    if (lat == null || lng == null || tsStr.isEmpty) {
      return null;
    }

    DateTime? ts;
    try {
      ts = DateTime.parse(tsStr);
    } catch (_) {
      return null;
    }

    return AppLocation(latitude: lat, longitude: lng, timestamp: ts);
  }

  AppLocation _tempLocation() {
    return AppLocation(latitude: 33.5138, longitude: 36.2765, timestamp: DateTime.now());
  }
}

// Simple exception to allow the VM/UI to react
class LocationException implements Exception {
  final AppLocationPermissionStatus status;

  LocationException(this.status);

  @override
  String toString() => 'LocationException: $status';
}
