import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/models/error_model.dart';
import 'package:lawaen/app/network/app_api.dart';
import 'package:lawaen/app/network/exceptions.dart';
import 'package:lawaen/features/add_to_app/data/models/add_event_model.dart';
import 'package:lawaen/features/add_to_app/data/models/add_missing_plcae_model.dart';
import 'package:lawaen/features/add_to_app/data/models/add_offer_model.dart';
import 'package:lawaen/features/add_to_app/data/repos/add_to_app_repo.dart';
import 'package:lawaen/features/add_to_app/presentation/params/add_event_params.dart';
import 'package:lawaen/features/add_to_app/presentation/params/add_missing_place_params.dart';
import 'package:lawaen/features/add_to_app/presentation/params/add_offer_params.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

@Injectable(as: AddToAppRepo)
class AddTopAppRepoImpl implements AddToAppRepo {
  final AppServiceClient appServiceClient;

  AddTopAppRepoImpl(this.appServiceClient);

  @override
  Future<Either<ErrorModel, AddEventModel>> addEvent(AddEventParams params) async {
    try {
      MultipartFile? imageFile;

      if (params.imageFile != null) {
        imageFile = await MultipartFile.fromFile(
          params.imageFile!.path,
          filename: params.imageFile!.path.split('/').last,
        );
      }

      final response = await appServiceClient.addEvent(
        eventType: params.eventType,
        name: params.name,
        description: params.description,
        bookingMethod: params.bookingMethod,
        price: params.price,
        organization: params.organization,
        startTime: params.startTime,
        endTime: params.endTime,
        startDate: params.startDate,
        endDate: params.endDate,
        startEventDate: params.startEventDate,
        endEventDate: params.endEventDate,
        eventTime: params.eventTime,
        note: params.note,
        phone: params.contact.phone,
        whatsapp: params.contact.whatsapp,
        instagram: params.contact.instagram,
        facebook: params.contact.facebook,
        latitude: params.location.lat,
        longitude: params.location.lng,
        image: imageFile,
      );

      if (response != null) {
        return Right(response);
      }

      return Left(ErrorModel(errorMessage: LocaleKeys.defaultError.tr()));
    } on DioException catch (e) {
      log("addEvent error: ${e.toString()}");
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }

  @override
  Future<Either<ErrorModel, AddMissingPlcaeModel>> addMissingPlace(AddMissingPlaceParams params) async {
    try {
      MultipartFile? imageFile;

      if (params.imageFile != null) {
        imageFile = await MultipartFile.fromFile(
          params.imageFile!.path,
          filename: params.imageFile!.path.split('/').last,
        );
      }

      final response = await appServiceClient.addMissingPlace(
        name: params.name,
        mainCategory: params.mainCategory,
        subCategory: params.subCategory,
        message: params.description,
        phone: params.contact.phone,
        whatsapp: params.contact.whatsapp,
        facebook: params.contact.facebook,
        instagram: params.contact.instagram,
        openTime: params.openTime,
        closeTime: params.closeTime,
        latitude: params.location.lat,
        longitude: params.location.lng,
        acceptOne: params.acceptOptions.acceptOne,
        acceptTwo: params.acceptOptions.acceptTwo,
        acceptThree: params.acceptOptions.acceptThree,
        recaptcha: params.recaptcha,
        image: imageFile,
      );

      if (response != null) {
        return Right(response);
      }

      return Left(ErrorModel(errorMessage: LocaleKeys.defaultError.tr()));
    } on DioException catch (e) {
      log("addMissingPlace error: ${e.toString()}");
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }

  @override
  Future<Either<ErrorModel, AddOfferModel>> addOffer(AddOfferParams params) async {
    try {
      MultipartFile? imageFile;

      if (params.imageFile != null) {
        imageFile = await MultipartFile.fromFile(
          params.imageFile!.path,
          filename: params.imageFile!.path.split('/').last,
        );
      }

      final response = await appServiceClient.addOffer(
        name: params.name,
        message: params.description,
        phone: params.contact.phone,
        whatsapp: params.contact.whatsapp,
        acceptOne: params.acceptOptions.acceptOne,
        acceptTwo: params.acceptOptions.acceptTwo,
        acceptThree: params.acceptOptions.acceptThree,
        recaptcha: params.recaptcha,
        image: imageFile,
      );

      if (response != null) {
        return Right(response);
      }

      return Left(ErrorModel(errorMessage: LocaleKeys.defaultError.tr()));
    } on DioException catch (e) {
      log("addOffer error: ${e.toString()}");
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }
}
