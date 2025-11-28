import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lawaen/app/core/models/error_model.dart';
import 'package:lawaen/app/network/exceptions.dart';
import 'package:lawaen/features/home/data/models/category_details_model.dart';
import 'package:lawaen/app/network/app_api.dart';
import 'package:lawaen/features/home/data/repos/category_details_repo/cetagory_details_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/features/home/presentation/params/get_category_details_params.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

@Injectable(as: CategoryDetailsRepo)
class CategoryDetailsRepoImpl implements CategoryDetailsRepo {
  final AppServiceClient appServiceClient;

  CategoryDetailsRepoImpl(this.appServiceClient);

  @override
  Future<Either<ErrorModel, List<CategoryDetailsModel>>> getCategoryDetails(
    String id,
    GetCategoryDetailsParams params,
  ) async {
    try {
      final response = await appServiceClient.getCategoryDetails(id: id, params: params);
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(ErrorModel(errorMessage: response.message ?? LocaleKeys.defaultError.tr()));
    } on DioException catch (e) {
      log("getCategoryDetails error: ${e.toString()}");
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }
}
