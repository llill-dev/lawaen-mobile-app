import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lawaen/app/external/models/weather_error_model.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class WeatherExceptionMapper {
  static WeatherErrorModel map(dynamic error) {
    if (error is DioException) {
      // No internet
      if (error.error is SocketException) {
        return WeatherErrorModel(message: LocaleKeys.noInternetConnection.tr());
      }

      // Timeout
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        return WeatherErrorModel(message: LocaleKeys.noInternetConnection.tr());
      }

      // Bad response (4xx / 5xx)
      if (error.response != null) {
        return WeatherErrorModel(message: LocaleKeys.defaultError.tr());
      }
    }

    return WeatherErrorModel(message: LocaleKeys.unKnownError.tr());
  }
}
