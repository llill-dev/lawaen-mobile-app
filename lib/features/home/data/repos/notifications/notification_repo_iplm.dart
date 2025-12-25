import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/models/error_model.dart';
import 'package:lawaen/app/network/app_api.dart';
import 'package:lawaen/app/network/exceptions.dart';
import 'package:lawaen/features/home/data/models/notification_model.dart';
import 'package:lawaen/features/home/data/repos/notifications/notification_repo.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

@Injectable(as: NotificationRepo)
class NotificationRepoImpl implements NotificationRepo {
  final AppServiceClient appServiceClient;

  NotificationRepoImpl(this.appServiceClient);

  @override
  Future<Either<ErrorModel, List<NotificationModel>>> getNotifications() async {
    try {
      final response = await appServiceClient.getNotifications();
      if (response.status == true && response.data != null) {
        return Right(response.data!);
      }
      return Left(ErrorModel(errorMessage: response.message ?? LocaleKeys.defaultError.tr()));
    } on DioException catch (e) {
      log("getNotifications error: ${e.toString()}");
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }

  @override
  Future<Either<ErrorModel, NotificationModel>> getUpNotification({required String notificationId}) async {
    try {
      final response = await appServiceClient.getUpNotification(notificationId: notificationId);
      if (response.status == true && response.data != null) {
        return Right(response.data!);
      }
      return Left(ErrorModel(errorMessage: response.message ?? LocaleKeys.defaultError.tr()));
    } on DioException catch (e) {
      log("getUpNotification error: ${e.toString()}");
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }

  @override
  Future<Either<ErrorModel, NotificationModel>> markAsRead({required String notificationId}) async {
    try {
      final response = await appServiceClient.markNotificationAsRead(notificationId: notificationId);
      if (response.status == true && response.data != null) {
        return Right(response.data!);
      }
      return Left(ErrorModel(errorMessage: response.message ?? LocaleKeys.defaultError.tr()));
    } on DioException catch (e) {
      log("markAsRead error: ${e.toString()}");
      return Left(ErrorModel.fromException(e.convertToAppException()));
    }
  }
}
