import 'dart:convert';
import 'dart:ui';

import 'package:injectable/injectable.dart';
import 'package:lawaen/features/auth/data/models/basic_user_info_model.dart';
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
const String prefsFcmToken = "prefs_fcm_token";
const String prefsUserInfo = "prefs_user_info";
const String prefsFcmRegistered = "prefs_fcm_registered";
const String prefsExploreRecentSearch = "prefs_explore_recent_search";

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

  Future<void> remove({required String prefsKey}) async {
    await _sharedPreferences.remove(prefsKey);
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

  Future<void> saveFcmToken(String token) async {
    await setString(prefsKey: prefsFcmToken, value: token);
  }

  String get fcmToken => getString(prefsKey: prefsFcmToken);

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
    await _sharedPreferences.remove(prefsToken);
    await _sharedPreferences.remove(prefsGuest);
    await _sharedPreferences.remove(refreshToken);
    await _sharedPreferences.remove(prefsUserInfo);
    await _sharedPreferences.remove(prefsFcmRegistered);
  }
}

extension UserInfoPrefs on AppPreferences {
  Future<void> saveUserInfo(BasicUserInfo user) async {
    final jsonString = jsonEncode(user.toJson());
    await setString(prefsKey: prefsUserInfo, value: jsonString);
  }

  BasicUserInfo? getUserInfo() {
    final jsonString = getString(prefsKey: prefsUserInfo);
    if (jsonString.isEmpty) return null;
    return BasicUserInfo.fromJson(jsonDecode(jsonString));
  }

  Future<void> clearUserInfo() async {
    await _sharedPreferences.remove(prefsUserInfo);
  }
}

extension FcmPrefs on AppPreferences {
  Future<void> setFcmRegistered(bool value) async {
    await setBool(prefsKey: prefsFcmRegistered, value: value);
  }

  bool get isFcmRegistered => getBool(prefsKey: prefsFcmRegistered);
}

extension ExploreSearchPrefs on AppPreferences {
  Future<void> saveExploreRecentSearch(List<String> searches) async {
    await setString(prefsKey: prefsExploreRecentSearch, value: jsonEncode(searches));
  }

  List<String> getExploreRecentSearch() {
    final raw = getString(prefsKey: prefsExploreRecentSearch);
    if (raw.isEmpty) return [];
    return List<String>.from(jsonDecode(raw));
  }
}
