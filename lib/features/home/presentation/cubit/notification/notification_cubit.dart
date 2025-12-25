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
          notifications: const [],
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
    emit(state.copyWith(markReadState: RequestState.loading, markReadError: null, markReadLoadingId: notificationId));

    final result = await _notificationRepo.markAsRead(notificationId: notificationId);

    await result.fold(
      (failure) async {
        emit(
          state.copyWith(
            markReadState: RequestState.error,
            markReadError: failure.errorMessage,
            markReadLoadingId: null,
          ),
        );
        showToast(message: failure.errorMessage, isError: true);
      },
      (updatedNotification) async {
        emit(
          state.copyWith(
            markReadState: RequestState.success,
            lastReadNotification: updatedNotification,
            markReadError: null,
            markReadLoadingId: null,
          ),
        );

        await getNotifications(isLoadMore: false);

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
