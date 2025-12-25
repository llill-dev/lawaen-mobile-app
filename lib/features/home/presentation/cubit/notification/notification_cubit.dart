import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/features/home/data/models/notification_model.dart';
import 'package:lawaen/features/home/data/repos/notifications/notification_repo.dart';

part 'notification_state.dart';

@singleton
class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepo _notificationRepo;

  NotificationCubit(this._notificationRepo) : super(const NotificationState());

  Future<void> getNotifications() async {
    emit(state.copyWith(listState: RequestState.loading, listError: null));

    final result = await _notificationRepo.getNotifications();
    result.fold(
      (failure) {
        emit(state.copyWith(listState: RequestState.error, listError: failure.errorMessage));
      },
      (notifications) {
        emit(state.copyWith(listState: RequestState.success, notifications: notifications, listError: null));
      },
    );
  }

  Future<void> getUpNotification({required String notificationId}) async {
    emit(state.copyWith(detailsState: RequestState.loading, detailsError: null));

    final result = await _notificationRepo.getUpNotification(notificationId: notificationId);
    result.fold(
      (failure) {
        emit(state.copyWith(detailsState: RequestState.error, detailsError: failure.errorMessage));
      },
      (notification) {
        emit(
          state.copyWith(detailsState: RequestState.success, selectedNotification: notification, detailsError: null),
        );
      },
    );
  }

  Future<void> markAsRead({required String notificationId}) async {
    emit(state.copyWith(markReadState: RequestState.loading, markReadError: null));

    final result = await _notificationRepo.markAsRead(notificationId: notificationId);
    result.fold(
      (failure) {
        emit(state.copyWith(markReadState: RequestState.error, markReadError: failure.errorMessage));
      },
      (notification) {
        // update selected + list locally
        final updatedList = state.notifications.map((n) {
          if (n.id == notification.id) return notification;
          return n;
        }).toList();

        emit(
          state.copyWith(
            markReadState: RequestState.success,
            selectedNotification: state.selectedNotification?.id == notification.id
                ? notification
                : state.selectedNotification,
            notifications: updatedList,
            markReadError: null,
          ),
        );
      },
    );
  }

  /// THEME: mark all as read locally (UI theme behavior, no API)
  void markAllAsReadLocal() {
    final updated = state.notifications
        .map(
          (n) => NotificationModel(
            id: n.id,
            title: n.title,
            body: n.body,
            imageUrl: n.imageUrl,
            createdAt: n.createdAt,
            isRead: true,
          ),
        )
        .toList();

    emit(state.copyWith(notifications: updated));
  }

  /// THEME: clear selection (useful for navigation)
  void clearSelected() {
    emit(state.copyWith(selectedNotification: null));
  }
}
