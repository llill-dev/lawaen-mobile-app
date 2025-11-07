import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../generated/locale_keys.g.dart';

/// Enum to represent different API error codes for better maintainability.
enum ApiErrorCode {
  noInternet,
  unauthorized,
  notFound,
  serverError,
  unknownError,
  cacheError,
  sessionTimedOut,
  badRequest,
}

/// Base class for API exceptions with detailed message and error code.
class AppException implements Exception {
  final String? message;
  final ApiErrorCode? code;
  final dynamic data;

  AppException({this.message, this.code, this.data});

  /// Factory method to convert Dio response into the AppException.
  factory AppException.fromDioResponse(Map<String, dynamic> json) {
    final message = json['message'] ?? LocaleKeys.defaultError.tr();
    final status = json['status'];

    ApiErrorCode errorCode;
    switch (status) {
      case 200:
        errorCode = ApiErrorCode.unknownError;
        break;
      case 403:
        errorCode = ApiErrorCode.unauthorized;
        break;
      case 404:
        errorCode = ApiErrorCode.notFound;
        break;
      case 500:
        errorCode = ApiErrorCode.serverError;
        break;
      default:
        errorCode = ApiErrorCode.unknownError;
    }

    return AppException(message: message, code: errorCode, data: json['data']);
  }

  @override
  String toString() {
    return '$message (Code: ${code.toString()})';
  }
}

/// Specific exceptions for various error scenarios
class FetchDataException extends AppException {
  FetchDataException({String? message, super.data})
    : super(message: message ?? LocaleKeys.unKnownError.tr(), code: ApiErrorCode.unknownError);
}

class NoInternetException extends AppException {
  NoInternetException({String? message, super.data})
    : super(message: message ?? LocaleKeys.noInternetConnection.tr(), code: ApiErrorCode.noInternet);
}

class NoItemsException extends AppException {
  NoItemsException({String? message, super.data})
    : super(message: message ?? LocaleKeys.noItems.tr(), code: ApiErrorCode.unknownError);
}

class BadRequestException extends AppException {
  BadRequestException({String? message, super.data})
    : super(message: message ?? LocaleKeys.badRequest.tr(), code: ApiErrorCode.badRequest);
}

class UnauthorisedException extends AppException {
  UnauthorisedException({String? message, super.data})
    : super(message: message ?? LocaleKeys.unauthorized.tr(), code: ApiErrorCode.unauthorized);
}

class NotFoundException extends AppException {
  NotFoundException({String? message, super.data})
    : super(message: message ?? LocaleKeys.notFound.tr(), code: ApiErrorCode.notFound);
}

class InvalidInputException extends AppException {
  InvalidInputException({String? message, super.data})
    : super(message: message ?? LocaleKeys.invalidInput.tr(), code: ApiErrorCode.unknownError);
}

class ServerErrorException extends AppException {
  ServerErrorException({String? message, super.data})
    : super(message: message ?? LocaleKeys.internalServerError.tr(), code: ApiErrorCode.serverError);
}

class CacheException extends AppException {
  CacheException({String? message, super.data})
    : super(message: message ?? LocaleKeys.cacheError.tr(), code: ApiErrorCode.cacheError);
}

class SessionTimedOutException extends AppException {
  SessionTimedOutException({String? message, super.data})
    : super(message: message ?? LocaleKeys.sessionTimedOut.tr(), code: ApiErrorCode.sessionTimedOut);
}

/// Extension on DioException to map Dio errors into custom AppException
extension ExceptionExtension on DioException {
  AppException convertToAppException() {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NoInternetException();
      case DioExceptionType.badResponse:
        if (response?.statusCode == 403) {
          return UnauthorisedException();
        } else {
          return AppException.fromDioResponse(response?.data);
        }
      case DioExceptionType.cancel:
      case DioExceptionType.unknown:
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
        if (error is SocketException) {
          return NoInternetException();
        }
        return FetchDataException();
    }
  }
}
