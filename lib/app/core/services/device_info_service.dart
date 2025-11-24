import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:lawaen/app/app_prefs.dart';
import 'package:lawaen/app/core/models/mobile_info_model.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@LazySingleton()
class DeviceInfoService {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  final AppPreferences _prefs;

  DeviceInfoService(this._prefs);

  Future<MobileInfo> getDeviceInfo() async {
    final buildId = await _getOrCreateDeviceId();

    if (kIsWeb) {
      return MobileInfo(brand: "Web", modelName: "Browser", isDevice: true, buildId: buildId);
    }

    if (Platform.isAndroid) {
      final android = await _deviceInfo.androidInfo;
      return MobileInfo(
        brand: android.brand,
        modelName: android.model,
        isDevice: android.isPhysicalDevice,
        buildId: buildId,
      );
    }

    if (Platform.isIOS) {
      final ios = await _deviceInfo.iosInfo;
      return MobileInfo(
        brand: "Apple",
        modelName: ios.utsname.machine,
        isDevice: ios.isPhysicalDevice,
        buildId: buildId,
      );
    }

    return MobileInfo(brand: "Unknown", modelName: "Unknown", isDevice: true, buildId: buildId);
  }

  Future<String> _getOrCreateDeviceId() async {
    const key = "device_id";

    String storedId = _prefs.getString(prefsKey: key);
    if (storedId.isNotEmpty) return storedId;

    final uuid = const Uuid().v4();
    await _prefs.setString(prefsKey: key, value: uuid);
    return uuid;
  }
}
