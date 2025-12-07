import 'package:dartz/dartz.dart';
import 'package:lawaen/app/core/models/error_model.dart';
import 'package:lawaen/features/add_to_app/data/models/add_event_model.dart';
import 'package:lawaen/features/add_to_app/data/models/add_missing_plcae_model.dart';
import 'package:lawaen/features/add_to_app/data/models/add_offer_model.dart';
import 'package:lawaen/features/add_to_app/presentation/params/add_event_params.dart';
import 'package:lawaen/features/add_to_app/presentation/params/add_missing_place_params.dart';
import 'package:lawaen/features/add_to_app/presentation/params/add_offer_params.dart';

abstract class AddToAppRepo {
  Future<Either<ErrorModel, AddEventModel>> addEvent(AddEventParams params);
  Future<Either<ErrorModel, AddMissingPlcaeModel>> addMissingPlace(AddMissingPlaceParams params);
  Future<Either<ErrorModel, AddOfferModel>> addOffer(AddOfferParams params);
}
