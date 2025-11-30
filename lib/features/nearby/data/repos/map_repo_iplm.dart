import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/models/error_model.dart';
import 'package:lawaen/app/network/app_api.dart';
import 'package:lawaen/app/network/exceptions.dart';
import 'package:lawaen/features/home/data/models/category_details_model.dart';
import 'package:lawaen/features/home/data/models/category_model.dart';
import 'package:lawaen/features/home/data/repos/home_repo/home_repo.dart';
import 'package:lawaen/features/home/data/repos/category_details_repo/cetagory_details_repo.dart';
import 'package:lawaen/features/home/presentation/params/get_category_details_params.dart';
import 'package:lawaen/generated/locale_keys.g.dart';
import 'map_repo.dart';

@Injectable(as: MapRepo)
class MapRepoImpl implements MapRepo {
  final AppServiceClient appServiceClient;
  final HomeRepo homeRepo;
  final CategoryDetailsRepo categoryDetailsRepo;

  MapRepoImpl(this.appServiceClient, this.homeRepo, this.categoryDetailsRepo);

  @override
  Future<Either<ErrorModel, List<CategoryDetailsModel>>> getInitialItems(GetCategoryDetailsParams params) async {
    try {
      final response = await appServiceClient.searchLocation(params: params);

      if (response.status && response.data != null) {
        return Right(response.data!);
      }

      return Left(ErrorModel(errorMessage: response.message ?? LocaleKeys.defaultError.tr()));
    } on DioException catch (e) {
      log("getInitialItems error: ${e.toString()}");
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }

  @override
  Future<Either<ErrorModel, List<CategoryModel>>> getCategories() async {
    return await homeRepo.getCategories();
  }

  @override
  Future<Either<ErrorModel, List<CategoryDetailsModel>>> getItemsByCategory(
    String categoryId,
    GetCategoryDetailsParams params,
  ) async {
    return await categoryDetailsRepo.getCategoryDetails(categoryId, params);
  }
}
