import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/app_prefs.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/network/urls.dart';
import 'package:lawaen/app/routes/router.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/auth/data/repo/auth_repo.dart';
import 'package:lawaen/features/auth/data/repo/auth_repo_iplm.dart';

@lazySingleton
class AuthInterceptor extends Interceptor {
  final AppPreferences appPreferences;
  bool _isRefreshing = false;

  AuthInterceptor(this.appPreferences);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = appPreferences.accessToken;

    final path = options.path;
    final isAuthCall = path.contains(Urls.login) || path.contains(Urls.register) || path.contains(Urls.refreshToken);

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

    // If not 401 → normal behavior
    if (statusCode != 401) {
      handler.next(err);
      return;
    }

    // Prevent infinite loop
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
          // refresh failed → logout and go to Login
          await appPreferences.logout();
          getIt<AppRouter>().replace(const LoginRoute());
          handler.next(err);
        },
        (_) async {
          // refresh success → retry original request with new token
          final newToken = appPreferences.accessToken;

          final requestOptions = err.requestOptions;
          requestOptions.headers['Authorization'] = "Bearer $newToken";

          final dio = getIt<Dio>();
          try {
            final response = await dio.fetch(requestOptions);
            handler.resolve(response);
          } catch (e) {
            handler.next(err);
          }
        },
      );
    } catch (e, st) {
      log('Error during token refresh: $e\n$st');
      handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }
}
