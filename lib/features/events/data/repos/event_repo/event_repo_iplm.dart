import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/models/error_model.dart';
import 'package:lawaen/app/network/app_api.dart';
import 'package:lawaen/app/network/exceptions.dart';
import 'package:lawaen/features/events/data/models/event_type_model.dart';
import 'package:lawaen/features/events/data/repos/event_repo/event_repo.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

@Injectable(as: EventRepo)
class EventRepoImpl implements EventRepo {
  final AppServiceClient appServiceClient;

  EventRepoImpl(this.appServiceClient);

  @override
  Future<Either<ErrorModel, List<EventTypeModel>>> getEventTypes() async {
    try {
      final response = await appServiceClient.getEventTypes();
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(ErrorModel(errorMessage: response.message ?? LocaleKeys.defaultError.tr()));
    } on DioException catch (e) {
      log("getEventTypes error: ${e.toString()}");
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }
}
