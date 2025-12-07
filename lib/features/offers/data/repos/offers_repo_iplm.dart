import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/models/error_model.dart';
import 'package:lawaen/app/network/app_api.dart';
import 'package:lawaen/app/network/exceptions.dart';
import 'package:lawaen/features/offers/data/models/offer_model.dart';
import 'package:lawaen/features/offers/data/models/offer_type_model.dart';
import 'package:lawaen/features/offers/data/repos/offers_repo.dart';
import 'package:lawaen/features/offers/presentation/params/get_offers_params.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

@Injectable(as: OffersRepo)
class OffersRepoImpl implements OffersRepo {
  final AppServiceClient appServiceClient;

  OffersRepoImpl(this.appServiceClient);

  @override
  Future<Either<ErrorModel, List<OfferTypeModel>>> getOfferTypes() async {
    try {
      final response = await appServiceClient.getOfferType();
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(ErrorModel(errorMessage: response.message ?? LocaleKeys.defaultError.tr()));
    } on DioException catch (e) {
      log("getOfferTypes error: ${e.toString()}");
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }

  @override
  Future<Either<ErrorModel, List<OfferModel>>> getOffers({required GetOffersParams params}) async {
    try {
      final response = await appServiceClient.getOffers(params: params);
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(ErrorModel(errorMessage: response.message ?? LocaleKeys.defaultError.tr()));
    } on DioException catch (e) {
      log("getOffers error: ${e.toString()}");
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }
}
