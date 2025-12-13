import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/functions/toast_message.dart';
import 'package:lawaen/app/core/models/error_model.dart';
import 'package:lawaen/app/network/app_api.dart';
import 'package:lawaen/app/network/exceptions.dart';
import 'package:lawaen/features/home/data/models/category_item_model.dart';
import 'package:lawaen/features/home/data/models/send_feed_back_model.dart';
import 'package:lawaen/features/home/data/models/toggle_model.dart';
import 'package:lawaen/features/home/data/repos/category_item_details_repo/category_item_details_repo.dart';
import 'package:lawaen/features/home/presentation/params/rate_item_params.dart';
import 'package:lawaen/features/home/presentation/params/send_feed_back_params.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

@Injectable(as: CategoryItemDetailsRepo)
class CategoryItemDetailsRepoImpl implements CategoryItemDetailsRepo {
  final AppServiceClient appServiceClient;

  CategoryItemDetailsRepoImpl(this.appServiceClient);
  @override
  Future<Either<ErrorModel, ItemData>> getCategoryItems({
    required String itemId,
    required String secondCategoryId,
  }) async {
    try {
      final response = await appServiceClient.getItemData(secondId: secondCategoryId, id: itemId);
      if (response.status == true && response.data != null) {
        return Right(response.data!);
      }
      return Left(ErrorModel(errorMessage: response.message ?? LocaleKeys.defaultError.tr()));
    } on DioException catch (e) {
      log("getCategoryItems error: ${e.toString()}");
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }

  @override
  Future<Either<ErrorModel, ToggleModel>> toggleFavorite({
    required String secondCategoryId,
    required String itemId,
  }) async {
    try {
      final response = await appServiceClient.toggleFavorite(secondId: secondCategoryId, id: itemId);
      if (response.status == true && response.data != null) {
        if (response.message != null) {
          showToast(message: response.message!);
        }
        return Right(response.data!);
      }
      return Left(ErrorModel(errorMessage: response.message ?? LocaleKeys.defaultError.tr()));
    } on DioException catch (e) {
      log("Toglee error: ${e.toString()}");
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }

  @override
  Future<Either<ErrorModel, Unit>> reateItem({
    required String secondCategoryId,
    required String itemId,
    required RateItemParams params,
  }) async {
    try {
      final response = await appServiceClient.rateItem(secondId: secondCategoryId, id: itemId, params: params);
      if (response.success == true) {
        if (response.message != null) {
          showToast(message: response.message!);
        }
        return Right(unit);
      }
      return Left(ErrorModel(errorMessage: response.message ?? LocaleKeys.defaultError.tr()));
    } on DioException catch (e) {
      log("reate item error: ${e.toString()}");
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }

  @override
  Future<Either<ErrorModel, SendFeedBackModel>> sendFeedBack({
    required String secondCategoryId,
    required String itemId,
    required SendFeedBackParams params,
  }) async {
    try {
      final response = await appServiceClient.sendFeedBack(secondId: secondCategoryId, id: itemId, params: params);
      if (response.created == true) {
        return Right(response);
      }
      return Left(ErrorModel(errorMessage: LocaleKeys.defaultError.tr()));
    } on DioException catch (e) {
      log("sendFeedBack error: ${e.toString()}");
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }
}
