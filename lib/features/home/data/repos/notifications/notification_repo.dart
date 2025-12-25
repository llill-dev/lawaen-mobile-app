import 'package:dartz/dartz.dart';
import 'package:lawaen/app/core/models/error_model.dart';
import 'package:lawaen/app/core/params/pagination_params.dart';
import 'package:lawaen/features/home/data/models/notification_model.dart';

abstract class NotificationRepo {
  Future<Either<ErrorModel, List<NotificationModel>>> getNotifications({required PaginationParams paginationParams});

  Future<Either<ErrorModel, NotificationModel>> getUpNotification({required String notificationId});

  Future<Either<ErrorModel, NotificationModel>> markAsRead({required String notificationId});
}
