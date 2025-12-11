import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/app_prefs.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/network/urls.dart';
import 'package:lawaen/app/routes/router.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/auth/data/repo/auth_repo_iplm.dart';
import 'package:package_info_plus/package_info_plus.dart';

@lazySingleton
class AuthInterceptor extends Interceptor {
  final AppPreferences appPreferences;
  bool _isRefreshing = false;

  AuthInterceptor(this.appPreferences);

  Future<String> _getBuildNumber() async {
    final info = await PackageInfo.fromPlatform();
    return info.buildNumber;
  }

  String _generateTimestamp() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  String _generateSignature() {
    final String secretKey = dotenv.env['X_Signature'] ?? "";
    return secretKey;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = appPreferences.accessToken;
    final path = options.path;

    final isAuthCall = path.contains(Urls.login) || path.contains(Urls.register) || path.contains(Urls.refreshToken);

    final timestamp = _generateTimestamp();
    final buildNumber = await _getBuildNumber();

    final signature = _generateSignature();

    options.headers.addAll({
      "x-timestamp": timestamp,
      "x-signature": signature,
      "User-Agent": "lawaenApp/$buildNumber",
      "Content-Type": "application/json",
    });

    if (token.isNotEmpty && !isAuthCall) {
      options.headers['Authorization'] = "Bearer $token";
      log('🔑 Using persisted token', name: "AuthInterceptor");
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode ?? 400;

    if (statusCode != 401) {
      handler.next(err);
      return;
    }

    if (_isRefreshing) {
      handler.next(err);
      return;
    }

    _isRefreshing = true;

    try {
      final authRepo = getIt<AuthRepoImpl>();
      final refreshResult = await authRepo.refreshToken();

      await refreshResult.fold(
        (error) async {
          await appPreferences.logout();
          getIt<AppRouter>().replace(const LoginRoute());
          handler.next(err);
        },
        (_) async {
          final newToken = appPreferences.accessToken;

          final requestOptions = err.requestOptions;
          requestOptions.headers['Authorization'] = "Bearer $newToken";

          final dio = getIt<Dio>();

          try {
            final response = await dio.fetch(requestOptions);
            handler.resolve(response);
          } catch (_) {
            handler.next(err);
          }
        },
      );
    } finally {
      _isRefreshing = false;
    }
  }
}
