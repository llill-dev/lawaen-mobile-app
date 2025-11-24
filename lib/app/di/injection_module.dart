import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/app_prefs.dart';
import 'package:lawaen/app/config/configuration.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/router.dart';

const String applicationJson = "application/json";
const String contentType = "Content-Type";
const String accept = "Accept";
const String authorization = "Authorization";
const String language = "lang";

@module
abstract class InjectableModule {
  @preResolve
  @lazySingleton
  Future<SharedPreferences> get sharedPref => SharedPreferences.getInstance();

  @lazySingleton
  Dio dioInstance(AppPreferences appPrefs, Configuration config) {
    final dio = Dio(
      BaseOptions(
        baseUrl: config.getBaseUrl,
        headers: {accept: applicationJson},
        connectTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = appPrefs.getString(prefsKey: "token");

          if (token.isNotEmpty) {
            options.headers[authorization] = "Bearer $token";
          }

          options.headers[language] = appPrefs.getAppLanguage();

          final deviceId = appPrefs.getString(prefsKey: "device_id");
          options.headers["x-device-id"] = deviceId;

          options.headers.putIfAbsent(contentType, () => applicationJson);

          handler.next(options);
        },
      ),
    );

    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(requestHeader: true, requestBody: true, responseHeader: false, responseBody: true),
      );
    }

    return dio;
  }

  @lazySingleton
  AppRouter get router => AppRouter();
}
