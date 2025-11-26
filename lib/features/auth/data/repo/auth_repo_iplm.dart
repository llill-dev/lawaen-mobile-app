import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/app_prefs.dart';
import 'package:lawaen/app/core/models/api_response.dart';
import 'package:lawaen/app/core/models/error_model.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/network/app_api.dart';
import 'package:lawaen/app/network/exceptions.dart';
import 'package:lawaen/features/auth/data/models/user_model.dart';
import 'package:lawaen/features/auth/data/repo/auth_repo.dart';
import 'package:lawaen/features/auth/presentation/params/change_password_params.dart';
import 'package:lawaen/features/auth/presentation/params/login_params.dart';
import 'package:lawaen/features/auth/presentation/params/register_params.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AppServiceClient appServiceClient;
  final prefs = getIt<AppPreferences>();
  AuthRepoImpl({required this.appServiceClient});
  @override
  Future<Either<ErrorModel, UserModel>> register(RegisterParams params) async {
    try {
      // MultipartFile? file;
      // if (params.image != null) {
      //   file = await MultipartFile.fromFile(params.image!.path, filename: params.image!.path.split('/').last);
      // }

      final response = await appServiceClient.register(
        name: params.name,
        email: params.email,
        password: params.password,
        phone: params.phone,
        device: jsonEncode(params.device.toJson()),
        image: params.image,
      );

      //final response = await appServiceClient.register(params);

      if (_successResponse(response)) {
        await _saveTokens(
          accessToken: response.data!.tokens.accessToken,
          refreshToken: response.data!.tokens.refreshToken,
        );
        return Right(response.data!.user);
      }
      log("register error: ${response.message}");
      return Left(ErrorModel(errorMessage: response.message ?? LocaleKeys.defaultError.tr()));
    } on DioException catch (e) {
      log("register error: ${e.toString()}");
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }

  @override
  Future<Either<ErrorModel, UserModel>> login(LoginParams params) async {
    try {
      final response = await appServiceClient.login(params);
      if (_successResponse(response)) {
        prefs.setBool(prefsKey: isFisrtTime, value: false);
        await _saveTokens(
          accessToken: response.data!.tokens.accessToken,
          refreshToken: response.data!.tokens.refreshToken,
        );
        return Right(response.data!.user);
      }

      return Left(ErrorModel(errorMessage: response.message ?? LocaleKeys.defaultError.tr()));
    } on DioException catch (e) {
      log("login error: ${e.toString()}");
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }

  @override
  Future<Either<ErrorModel, UserModel>> chagnePassword(ChangePasswordParams params) async {
    try {
      final response = await appServiceClient.changePassword(params);
      if (_successResponse(response)) {
        return Right(response.data!.user);
      }
      return Left(ErrorModel(errorMessage: response.message ?? LocaleKeys.defaultError.tr()));
    } on DioException catch (e) {
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }

  @override
  Future<Either<ErrorModel, Unit>> refreshToken() async {
    try {
      final storedRefresh = prefs.storedRefreshToken;

      if (storedRefresh.isEmpty) {
        return Left(ErrorModel(errorMessage: "No refresh token stored"));
      }

      final token = await appServiceClient.refreshToken({"refreshToken": storedRefresh});

      log("refresh token response: $token:  ${token.accessToken} ${token.refreshToken}");

      final newAccess = token.accessToken;
      final newRefresh = token.refreshToken;

      if (newAccess.isEmpty || newRefresh.isEmpty) {
        log("Invalid refresh token response (empty tokens)");
        return Left(ErrorModel(errorMessage: "Invalid refresh token response"));
      }

      _saveTokens(accessToken: newAccess, refreshToken: newRefresh);

      return const Right(unit);
    } on DioException catch (e) {
      return Left(ErrorModel.fromException(e.convertToAppException()));
    } catch (e) {
      log("Unexpected refreshToken error: $e");
      return Left(ErrorModel(errorMessage: "Unexpected error refreshing token"));
    }
  }

  Future<void> _saveTokens({required String accessToken, required String refreshToken}) async {
    await prefs.saveTokens(accessToken: accessToken, refresh: refreshToken);
  }

  bool _successResponse(ApiResponse response) {
    return response.data != null && response.status;
  }
}
