import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/models/api_response.dart';
import 'package:lawaen/app/network/urls.dart';
import 'package:lawaen/features/auth/data/models/token_model.dart';
import 'package:lawaen/features/auth/data/models/user_model.dart';
import 'package:lawaen/features/auth/presentation/params/change_password_params.dart';
import 'package:lawaen/features/auth/presentation/params/login_params.dart';
import 'package:lawaen/features/home/data/models/category_details_model.dart';
import 'package:lawaen/features/home/data/models/category_model.dart';
import 'package:lawaen/features/home/data/models/city_model.dart';
import 'package:lawaen/features/home/presentation/params/get_category_details_params.dart';
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
  Future<ApiResponse<UserDataModel>> login(@Body() LoginParams params);

  @MultiPart()
  @POST(Urls.register)
  //Future<ApiResponse<UserDataModel>> register(@Body() RegisterParams params);
  Future<ApiResponse<UserDataModel>> register({
    @Part(name: "name") required String name,
    @Part(name: "email") String? email,
    @Part(name: "password") required String password,
    @Part(name: "phone") String? phone,
    @Part(name: "device") required String device,
    @Part(name: "image") File? image,
  });

  @POST(Urls.changePassword)
  Future<ApiResponse<UserDataModel>> changePassword(@Body() ChangePasswordParams params);

  @POST(Urls.refreshToken)
  Future<TokenModel> refreshToken(@Body() Map<String, dynamic> body);

  //Home
  @GET(Urls.getCities)
  Future<ApiResponse<List<CityModel>>> getCities();

  @GET(Urls.getCategories)
  Future<ApiResponse<List<CategoryModel>>> getCategories();

  //category details
  @GET(Urls.getCategoryDetails)
  Future<ApiResponse<List<CategoryDetailsModel>>> getCategoryDetails({
    @Queries() required GetCategoryDetailsParams params,
    @Path("id") required String id,
  });

  @GET(Urls.getCategoryDetailsBySecond)
  Future<ApiResponse<List<CategoryDetailsModel>>> getCategoryDetailsBySecond({
    @Queries() required GetCategoryDetailsParams params,
    @Path("id") required String id,
  });
}
