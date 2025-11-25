import 'dart:ui';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'di/injection.dart';
import 'resources/language_manager.dart';

const String prefsLang = "lang";
const String prefsGuest = "guest";
const String prefsToken = "prefs_token";
const String refreshToken = "refresh_token";

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
      return LanguageType.arabic.getValue();
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

  Future<void> logout() async {
    await _sharedPreferences.remove(prefsToken);
    await _sharedPreferences.remove(prefsGuest);
    await _sharedPreferences.remove(refreshToken);
    await configureInjection(Environment.prod);
  }
}
