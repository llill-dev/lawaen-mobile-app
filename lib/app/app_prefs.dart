import 'dart:ui';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'di/injection.dart';
import 'resources/language_manager.dart';

const String prefsLang = "lang";
const String prefsGuest = "guest";
const String prefsToken = "prefs_token";
const String refreshToken = "refresh_token";
const String prefsLat = "prefs_latitude";
const String prefsLng = "prefs_longitude";
const String prefsLocationTimestamp = "prefs_location_timestamp";
const String isFisrtTime = "is_fisrt_time";
const String prefsCityId = "prefs_city_id";
const String prefsCityName = "prefs_city_name";

@Injectable()
class AppPreferences {
  final _sharedPreferences = getIt<SharedPreferences>();

  Future<void> setString({required String prefsKey, required String value}) async {
    await _sharedPreferences.setString(prefsKey, value);
  }

  Future<void> setBool({required String prefsKey, required bool value}) async {
    await _sharedPreferences.setBool(prefsKey, value);
  }

  bool getBool({required String prefsKey}) {
    return _sharedPreferences.getBool(prefsKey) ?? false;
  }

  String getString({required String prefsKey}) {
    return _sharedPreferences.getString(prefsKey) ?? "";
  }

  String getAppLanguage() {
    String? language = _sharedPreferences.getString(prefsLang);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.english.getValue();
    }
  }

  Future<void> changeAppLanguage() async {
    String? currentLanguage = getAppLanguage();
    if (currentLanguage == LanguageType.arabic.getValue()) {
      await _sharedPreferences.setString(prefsLang, LanguageType.english.getValue());
    } else {
      await _sharedPreferences.setString(prefsLang, LanguageType.arabic.getValue());
    }
  }

  Future<Locale> getLocale() async {
    String? currentLanguage = getAppLanguage();
    if (currentLanguage == LanguageType.arabic.getValue()) {
      return arabicLocale;
    } else {
      return englishLocale;
    }
  }

  Future<void> setDouble({required String prefsKey, required double value}) async {
    await _sharedPreferences.setDouble(prefsKey, value);
  }

  double? getDouble({required String prefsKey}) {
    return _sharedPreferences.getDouble(prefsKey);
  }

  Future<void> saveUserCity(String id, String name) async {
    await setString(prefsKey: prefsCityId, value: id);
    await setString(prefsKey: prefsCityName, value: name);
  }

  String? get userCityId {
    return _sharedPreferences.getString(prefsCityId);
  }

  String get userCityName {
    return _sharedPreferences.getString(prefsCityName) ?? "";
  }

  // --------- AUTH HELPERS ---------

  Future<void> saveTokens({required String accessToken, required String refresh}) async {
    await setString(prefsKey: prefsToken, value: accessToken);
    await setString(prefsKey: refreshToken, value: refresh);
  }

  String get accessToken => _sharedPreferences.getString(prefsToken) ?? '';

  String get storedRefreshToken => _sharedPreferences.getString(refreshToken) ?? '';

  bool get isGuest => _sharedPreferences.getBool(prefsGuest) ?? false;

  Future<void> setGuest(bool value) async {
    await setBool(prefsKey: prefsGuest, value: value);
  }

  bool get isFirstTime => _sharedPreferences.getBool(isFisrtTime) ?? true;

  Future<void> setFirstTime(bool value) async {
    await setBool(prefsKey: isFisrtTime, value: value);
  }

  Future<void> logout() async {
    await _sharedPreferences.remove(prefsLat);
    await _sharedPreferences.remove(prefsLng);
    await _sharedPreferences.remove(prefsLocationTimestamp);
    await _sharedPreferences.remove(prefsToken);
    await _sharedPreferences.remove(prefsGuest);
    await _sharedPreferences.remove(refreshToken);
    await configureInjection(Environment.prod);
  }
}
