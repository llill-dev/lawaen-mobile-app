import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/app_prefs.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/network/urls.dart';
import 'package:lawaen/app/routes/router.dart';
import 'package:lawaen/app/routes/router.gr.dart';

@lazySingleton
class AuthInterceptor extends Interceptor {
  final AppPreferences appPreferences;

  AuthInterceptor(this.appPreferences);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (!options.path.contains(Urls.register) &&
        !options.path.contains(Urls.login) &&
        !appPreferences.getBool(prefsKey: prefsGuest)) {
      final token = appPreferences.getString(prefsKey: prefsToken);

      if (token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
        log('🔑 Using persisted token', name: "AuthInterceptor");
      }
    }

    if (!handler.isCompleted) {
      handler.next(options);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    String url = response.requestOptions.path;

    // Handle token storage based on endpoint
    if (url.contains(Urls.login) || url.contains(Urls.register)) {
      final data = response.data['data'];
      if (data != null && data['access_token'] != null && data['refresh_token'] != null) {
        String token = data['access_token'];
        String refreshToken = data['refresh_token'];

        if (token.isNotEmpty && refreshToken.isNotEmpty) {
          appPreferences.setString(prefsKey: prefsToken, value: token);
          appPreferences.setString(prefsKey: refreshToken, value: refreshToken);
          log(
            '💾 Token persisted for ${url.contains(Urls.login) ? "login" : "regular signup"}',
            name: "AuthInterceptor",
          );
        }
      }
    }

    final statusCode = response.statusCode ?? 400;
    if (statusCode == 401) {
      getIt<AppRouter>().replace(const LoginRoute());
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);

    final statusCode = err.response?.statusCode ?? 400;
    if (statusCode == 401) {
      getIt<AppRouter>().replace(const LoginRoute());
    }
  }
}
