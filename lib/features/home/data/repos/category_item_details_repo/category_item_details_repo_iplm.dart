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
import 'package:lawaen/features/home/data/models/toggle_model.dart';
import 'package:lawaen/features/home/data/repos/category_item_details_repo/category_item_details_repo.dart';
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
      log("getCategoryItems error: ${e.toString()}");
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }
}
