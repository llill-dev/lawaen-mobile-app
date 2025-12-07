import 'package:dartz/dartz.dart';
import 'package:lawaen/app/core/models/error_model.dart';
import 'package:lawaen/features/offers/data/models/offer_model.dart';
import 'package:lawaen/features/offers/data/models/offer_type_model.dart';
import 'package:lawaen/features/offers/presentation/params/get_offers_params.dart';

abstract class OffersRepo {
  Future<Either<ErrorModel, List<OfferTypeModel>>> getOfferTypes();

  Future<Either<ErrorModel, List<OfferModel>>> getOffers({required GetOffersParams params});
}
