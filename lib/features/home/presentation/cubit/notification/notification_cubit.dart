import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/functions/toast_message.dart';
import 'package:lawaen/app/core/params/pagination_params.dart';
import 'package:lawaen/app/core/services/notification_navigation_helper.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/routes/router.dart';
import 'package:lawaen/features/home/data/models/notification_model.dart';
import 'package:lawaen/features/home/data/repos/notifications/notification_repo.dart';

part 'notification_state.dart';

@singleton
class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepo _notificationRepo;
  final AppRouter _router;

  NotificationCubit(this._notificationRepo, this._router) : super(const NotificationState());

  Future<void> getNotifications({bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (!state.notificationsHasMore || state.isLoadMoreNotifications) return;
      emit(state.copyWith(isLoadMoreNotifications: true));
    } else {
      emit(
        state.copyWith(
          listState: RequestState.loading,
          listError: null,
          notifications: [],
          isLoadMoreNotifications: false,
          notificationsCurrentPage: 1,
          notificationsHasMore: true,
        ),
      );
    }

    final params = PaginationParams(
      page: isLoadMore ? state.notificationsCurrentPage : 1,
      limit: state.notificationsLimit,
    );

    final result = await _notificationRepo.getNotifications(paginationParams: params);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            listState: RequestState.error,
            listError: failure.errorMessage,
            isLoadMoreNotifications: false,
          ),
        );

        if (!isLoadMore) {
          showToast(message: failure.errorMessage, isError: true);
        }
      },
      (newNotifications) {
        final updatedList = isLoadMore ? [...state.notifications, ...newNotifications] : newNotifications;

        emit(
          state.copyWith(
            listState: RequestState.success,
            notifications: updatedList,
            listError: null,
            isLoadMoreNotifications: false,
            notificationsCurrentPage: isLoadMore ? state.notificationsCurrentPage + 1 : 2,
            notificationsHasMore: newNotifications.length >= state.notificationsLimit,
          ),
        );
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

  Future<void> markAsRead(String notificationId) async {
    // Update the local notification first for immediate UI feedback
    final updatedNotifications = List<NotificationModel>.from(state.notifications);
    final index = updatedNotifications.indexWhere((n) => n.id == notificationId);

    if (index != -1) {
      final notification = updatedNotifications[index];
      updatedNotifications[index] = notification.copyWith(isRead: true);

      emit(
        state.copyWith(notifications: updatedNotifications, markReadState: RequestState.loading, markReadError: null),
      );
    } else {
      emit(state.copyWith(markReadState: RequestState.loading, markReadError: null));
    }

    final result = await _notificationRepo.markAsRead(notificationId: notificationId);

    result.fold(
      (failure) {
        // Revert the local change on error
        if (index != -1) {
          final revertedNotifications = List<NotificationModel>.from(state.notifications);
          final originalNotification = revertedNotifications[index];
          revertedNotifications[index] = originalNotification.copyWith(isRead: false);

          emit(
            state.copyWith(
              notifications: revertedNotifications,
              markReadState: RequestState.error,
              markReadError: failure.errorMessage,
            ),
          );
        } else {
          emit(state.copyWith(markReadState: RequestState.error, markReadError: failure.errorMessage));
        }

        // Show error toast
        showToast(message: failure.errorMessage, isError: true);
      },
      (updatedNotification) {
        // Update with server response
        if (index != -1) {
          final finalNotifications = List<NotificationModel>.from(state.notifications);
          finalNotifications[index] = updatedNotification;

          emit(
            state.copyWith(
              notifications: finalNotifications,
              markReadState: RequestState.success,
              lastReadNotification: updatedNotification,
              markReadError: null,
            ),
          );
        } else {
          emit(
            state.copyWith(
              markReadState: RequestState.success,
              lastReadNotification: updatedNotification,
              markReadError: null,
            ),
          );
        }

        // Handle navigation if screen key exists
        final screen = updatedNotification.screen;
        if (screen != null && screen.trim().isNotEmpty) {
          _handleNotificationNavigation(updatedNotification);
        }
      },
    );
  }

  void _handleNotificationNavigation(NotificationModel notification) {
    final data = {
      'screen': notification.screen,
      'title': notification.title,
      'body': notification.body,
      '_id': notification.id,
      'dedupeKey': notification.dedupeKey,
    };

    NotificationNavigationHelper.handle(router: _router, data: data);
  }

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

  void clearSelected() {
    emit(state.copyWith(selectedNotification: null));
  }
}

extension NotificationModelCopyWith on NotificationModel {
  NotificationModel copyWith({
    String? id,
    String? title,
    String? body,
    bool? isRead,
    String? createdAt,
    String? imageUrl,
    String? screen,
    String? dedupeKey,
    String? userId,
    String? updatedAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      imageUrl: imageUrl ?? this.imageUrl,
      screen: screen ?? this.screen,
      dedupeKey: dedupeKey ?? this.dedupeKey,
      userId: userId ?? this.userId,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
