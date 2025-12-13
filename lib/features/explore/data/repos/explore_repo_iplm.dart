import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/models/error_model.dart';
import 'package:lawaen/app/network/app_api.dart';
import 'package:lawaen/app/network/exceptions.dart';
import 'package:lawaen/features/explore/data/models/user_preferences_model.dart';
import 'package:lawaen/features/explore/data/repos/explore_repo.dart';
import 'package:lawaen/features/home/data/models/category_details_model.dart';
import 'package:lawaen/features/home/presentation/params/get_category_details_params.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

@Injectable(as: ExploreRepo)
class ExploreRepoImpl implements ExploreRepo {
  final AppServiceClient appServiceClient;

  ExploreRepoImpl(this.appServiceClient);

  @override
  Future<Either<ErrorModel, List<CategoryDetailsModel>>> getExplore(GetCategoryDetailsParams params) async {
    try {
      final response = await appServiceClient.getExplore(params: params);
      if (response.status == true && response.data != null) {
        return Right(response.data!);
      }
      return Left(ErrorModel(errorMessage: response.message ?? LocaleKeys.defaultError.tr()));
    } on DioException catch (e) {
      log("getExplore error: ${e.toString()}");
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }

  @override
  Future<Either<ErrorModel, List<UserPreferencesModel>>> getUserPreferences() async {
    try {
      final response = await appServiceClient.getUserPreferences();
      if (response.status == true && response.data != null) {
        return Right(response.data!);
      }
      return Left(ErrorModel(errorMessage: response.message ?? LocaleKeys.defaultError.tr()));
    } on DioException catch (e) {
      log("getUserPreferences error: ${e.toString()}");
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }
}
