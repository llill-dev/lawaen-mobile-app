import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/models/error_model.dart';
import 'package:lawaen/app/network/app_api.dart';
import 'package:lawaen/app/network/exceptions.dart';
import 'package:lawaen/features/events/data/models/event_model.dart';
import 'package:lawaen/features/home/data/models/category_model.dart';
import 'package:lawaen/features/home/data/models/city_model.dart';
import 'package:lawaen/features/home/data/repos/home_repo/home_repo.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

@Injectable(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  final AppServiceClient appServiceClient;

  HomeRepoImpl(this.appServiceClient);
  @override
  Future<Either<ErrorModel, List<CityModel>>> getCities() async {
    try {
      final response = await appServiceClient.getCities();
      if (response.status && response.data != null) {
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
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(ErrorModel(errorMessage: response.message ?? LocaleKeys.defaultError.tr()));
    } on DioException catch (e) {
      log("getCategories error: ${e.toString()}");
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }

  @override
  Future<Either<ErrorModel, List<EventModel>>> getHomeEvents() async {
    try {
      final response = await appServiceClient.getHomeEvents();
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(ErrorModel(errorMessage: response.message ?? LocaleKeys.defaultError.tr()));
    } on DioException catch (e) {
      log("getCategories error: ${e.toString()}");
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }
}
