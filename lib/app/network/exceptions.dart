import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../generated/locale_keys.g.dart';

enum ApiErrorCode { noInternet, unauthorized, badRequest, serverError, notFound, unknown }

class AppException implements Exception {
  final String message;
  final ApiErrorCode code;

  AppException({required this.message, required this.code});

  /// Convert backend JSON → exception
  factory AppException.fromBackend(Map<String, dynamic> json) {
    final msg = json['message']?.toString() ?? LocaleKeys.defaultError.tr();

    return AppException(message: msg, code: ApiErrorCode.unknown);
  }

  factory AppException.fromCode(ApiErrorCode code) {
    switch (code) {
      case ApiErrorCode.noInternet:
        return AppException(message: LocaleKeys.noInternetConnection.tr(), code: ApiErrorCode.noInternet);
      case ApiErrorCode.unauthorized:
        return AppException(message: LocaleKeys.unauthorized.tr(), code: ApiErrorCode.unauthorized);
      case ApiErrorCode.badRequest:
        return AppException(message: LocaleKeys.badRequest.tr(), code: ApiErrorCode.badRequest);
      case ApiErrorCode.serverError:
        return AppException(message: LocaleKeys.internalServerError.tr(), code: ApiErrorCode.serverError);
      case ApiErrorCode.notFound:
        return AppException(message: LocaleKeys.notFound.tr(), code: ApiErrorCode.notFound);
      case ApiErrorCode.unknown:
        return AppException(message: LocaleKeys.unKnownError.tr(), code: ApiErrorCode.unknown);
    }
  }
}

extension ExceptionExtension on DioException {
  AppException convertToAppException() {
    // No internet
    if (error is SocketException) {
      return AppException.fromCode(ApiErrorCode.noInternet);
    }

    // Backend error JSON
    if (type == DioExceptionType.badResponse && response?.data != null) {
      final data = response!.data;

      // Expected backend format
      if (data is Map<String, dynamic> && data.containsKey('status')) {
        if (data['status'] == false) {
          return AppException.fromBackend(data);
        }
      }

      return AppException.fromCode(ApiErrorCode.unknown);
    }

    // Timeout
    if (type == DioExceptionType.connectionTimeout ||
        type == DioExceptionType.sendTimeout ||
        type == DioExceptionType.receiveTimeout) {
      return AppException.fromCode(ApiErrorCode.noInternet);
    }

    // Unauthorized (401, 403)
    if (response?.statusCode == 401 || response?.statusCode == 403) {
      return AppException.fromCode(ApiErrorCode.unauthorized);
    }

    // Server error
    if (response?.statusCode == 500) {
      return AppException.fromCode(ApiErrorCode.serverError);
    }

    return AppException.fromCode(ApiErrorCode.unknown);
  }
}
