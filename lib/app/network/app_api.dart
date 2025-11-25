import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/models/api_response.dart';
import 'package:lawaen/app/core/models/mobile_info_model.dart';
import 'package:lawaen/app/network/urls.dart';
import 'package:lawaen/features/auth/data/models/user_model.dart';
import 'package:lawaen/features/auth/presentation/params/change_password_params.dart';
import 'package:lawaen/features/auth/presentation/params/login_params.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../config/configuration.dart';
part 'app_api.g.dart';

@lazySingleton
@RestApi()
abstract class AppServiceClient {
  @factoryMethod
  factory AppServiceClient(Dio dio, Configuration configuration) {
    return _AppServiceClient(dio, baseUrl: configuration.getBaseUrl);
  }

  //Auth
  @POST(Urls.login)
  Future<ApiResponse<UserModel>> login(@Body() LoginParams params);

  @POST(Urls.register)
  Future<ApiResponse<UserModel>> register({
    @Part(name: "name") required String name,
    @Part(name: "email") String? email,
    @Part(name: "password") required String password,
    @Part(name: "phone") String? phone,
    @Part(name: "device") required MobileInfo device,
    @Part(name: "image") MultipartFile? image,
  });

  @POST(Urls.changePassword)
  Future<ApiResponse<UserModel>> changePassword(@Body() ChangePasswordParams params);
}
