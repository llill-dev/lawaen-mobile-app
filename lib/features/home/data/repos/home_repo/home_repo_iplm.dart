import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/models/error_model.dart';
import 'package:lawaen/app/external/exception/weather_exception_mapper.dart';
import 'package:lawaen/app/external/models/weather_error_model.dart';
import 'package:lawaen/app/network/app_api.dart';
import 'package:lawaen/app/network/exceptions.dart';
import 'package:lawaen/features/events/data/models/event_model.dart';
import 'package:lawaen/features/events/presentation/params/get_events_params.dart';
import 'package:lawaen/features/home/data/models/category_details_model.dart';
import 'package:lawaen/features/home/data/models/category_model.dart';
import 'package:lawaen/features/home/data/models/city_model.dart';
import 'package:lawaen/features/home/data/models/contact_model.dart';
import 'package:lawaen/features/home/data/models/mune_model.dart';
import 'package:lawaen/features/home/data/models/register_fcm_token_model.dart';
import 'package:lawaen/app/external/models/weather_model.dart';
import 'package:lawaen/features/home/data/repos/home_repo/home_repo.dart';
import 'package:lawaen/features/home/presentation/params/get_category_details_params.dart';
import 'package:lawaen/features/home/presentation/params/get_menu_params.dart';
import 'package:lawaen/app/external/params/get_weather_params.dart';
import 'package:lawaen/features/home/presentation/params/register_fcm_token_params.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

@Injectable(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  final AppServiceClient appServiceClient;

  HomeRepoImpl(this.appServiceClient);
  @override
  Future<Either<ErrorModel, List<CityModel>>> getCities() async {
    try {
      final response = await appServiceClient.getCities();
      if (response.status == true && response.data != null) {
        return Right(response.data!);
      }
      return Left(ErrorModel(errorMessage: response.message ?? LocaleKeys.defaultError.tr()));
    } on DioException catch (e) {
      log("getCities error: ${e.toString()}");
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }

  @override
  Future<Either<ErrorModel, List<CategoryModel>>> getCategories() async {
    try {
      final response = await appServiceClient.getCategories();
      if (response.status == true && response.data != null) {
        return Right(response.data!);
      }
      return Left(ErrorModel(errorMessage: response.message ?? LocaleKeys.defaultError.tr()));
    } on DioException catch (e) {
      log("getCategories error: ${e.toString()}");
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }

  @override
  Future<Either<ErrorModel, List<EventModel>>> getHomeEvents(GetEventsParams params) async {
    try {
      final response = await appServiceClient.getHomeEvents(params: params);
      if (response.status == true && response.data != null) {
        return Right(response.data!);
      }
      return Left(ErrorModel(errorMessage: response.message ?? LocaleKeys.defaultError.tr()));
    } on DioException catch (e) {
      log("getCategories error: ${e.toString()}");
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }

  @override
  Future<Either<ErrorModel, RegisterFcmTokenModel>> registerFcmToken(RegisterFcmTokenParams params) async {
    try {
      final response = await appServiceClient.registerFcmToken(params: params);
      if (response.success == true) {
        return Right(response);
      }
      return Left(ErrorModel(errorMessage: response.message ?? LocaleKeys.defaultError.tr()));
    } on DioException catch (e) {
      log("register fcm error: ${e.toString()}");
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }

  @override
  Future<Either<ErrorModel, List<CategoryDetailsModel>>> getHomeData(GetCategoryDetailsParams params) async {
    try {
      final response = await appServiceClient.getHomeData(params: params);

      if (response.status == true && response.data != null) {
        return Right(response.data!);
      }

      return Left(ErrorModel(errorMessage: response.message ?? LocaleKeys.defaultError.tr()));
    } on DioException catch (e) {
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }

  @override
  Future<Either<ErrorModel, MuneModel>> getMune(GetMenuParams params) async {
    try {
      final response = await appServiceClient.getMune(params: params);

      if (response.status == true && response.data != null) {
        return Right(response.data!);
      }

      return Left(ErrorModel(errorMessage: response.message ?? LocaleKeys.defaultError.tr()));
    } on DioException catch (e) {
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }

  @override
  Future<Either<ErrorModel, List<ContactModel>>> getContact() async {
    try {
      final response = await appServiceClient.getContact();

      if (response.status == true && response.data != null) {
        return Right(response.data!);
      }

      return Left(ErrorModel(errorMessage: response.message ?? LocaleKeys.defaultError.tr()));
    } on DioException catch (e) {
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }

  @override
  Future<Either<WeatherErrorModel, WeatherModel>> getWeather(GetWeatherParams params) async {
    try {
      final response = await appServiceClient.getWeather(params: params);
      final weather = WeatherModel(
        currentWeather: CurrentWeatherModel(
          temperature: response.currentWeather?.temperature ?? 0,
          weathercode: response.currentWeather?.weathercode ?? 0,
        ),
      );

      return Right(weather);
    } catch (e) {
      final error = WeatherExceptionMapper.map(e);
      return Left(error);
    }
  }
}
