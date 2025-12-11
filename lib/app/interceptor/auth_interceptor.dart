import 'dart:convert';
import 'dart:developer';
import 'package:crypto/crypto.dart';
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

  // Build number for user agent
  Future<String> _getBuildNumber() async {
    final info = await PackageInfo.fromPlatform();
    return info.buildNumber;
  }

  // Backend DOES NOT include /user/v2 in signatures
  String _normalizePath(String path) {
    // 1. If already correct → return
    if (path.startsWith("/user/v2")) {
      return path;
    }

    // 2. If starts with "/" but missing /user/v2
    if (path.startsWith("/")) {
      return "/user/v2$path"; // append after leading slash
    }

    // 3. If missing "/" entirely → Retrofit gives "event/event_home"
    return "/user/v2/$path";
  }

  String _timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  // Merge query params + body and convert values to String
  Map<String, dynamic> _mergeRequestData(RequestOptions options) {
    final Map<String, dynamic> data = {};

    // Query parameters always included in signature
    options.queryParameters.forEach((key, value) {
      data[key] = value.toString();
    });

    // Body (JSON only)
    if (options.data is Map) {
      (options.data as Map).forEach((key, value) {
        data[key] = value.toString();
      });
    }

    return data;
  }

  String _generateSignature({required String urlPath, required Map<String, dynamic> data, required String timestamp}) {
    final secretKey = dotenv.env['X_Signature'] ?? "";

    // Convert final merged data to JSON
    final String bodyJson = jsonEncode(data);

    final String payload = urlPath + bodyJson + timestamp;

    final hmac = Hmac(sha256, utf8.encode(secretKey));
    final hash = hmac.convert(utf8.encode(payload)).toString();

    return hash;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = appPreferences.accessToken;

    final timestamp = _timestamp();
    final buildNumber = await _getBuildNumber();

    // Normalize backend route path
    final path = _normalizePath(options.path);

    // Merge query params + body into one JSON object
    final mergedData = _mergeRequestData(options);

    // Backend signs GET requests even if they have {} only
    if (options.method == "GET") {
      // mergedData already contains params only
    }

    // Generate signature
    final signature = _generateSignature(urlPath: path, data: mergedData, timestamp: timestamp);

    // For debugging
    log("SIGN PATH: $path");
    log("SIGN DATA: $mergedData");
    log("TIMESTAMP: $timestamp");
    log("SIGNATURE: $signature");

    // Required headers
    options.headers.addAll({
      "User-Agent": "lawaenApp/$buildNumber",
      "x-timestamp": timestamp,
      "x-signature": signature,
      "Content-Type": "application/json",
    });

    // Add token logic
    final isAuthCall =
        options.path.contains(Urls.login) ||
        options.path.contains(Urls.register) ||
        options.path.contains(Urls.refreshToken);

    if (token.isNotEmpty && !isAuthCall) {
      options.headers["Authorization"] = "Bearer $token";
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final status = err.response?.statusCode ?? 400;

    if (status != 401) return handler.next(err);
    if (_isRefreshing) return handler.next(err);

    _isRefreshing = true;

    try {
      final refreshResult = await getIt<AuthRepoImpl>().refreshToken();

      await refreshResult.fold(
        (error) async {
          await appPreferences.logout();
          getIt<AppRouter>().replace(const LoginRoute());
          handler.next(err);
        },
        (_) async {
          final newToken = appPreferences.accessToken;

          final request = err.requestOptions;
          request.headers["Authorization"] = "Bearer $newToken";

          final dio = getIt<Dio>();
          final response = await dio.fetch(request);
          handler.resolve(response);
        },
      );
    } finally {
      _isRefreshing = false;
    }
  }
}
