part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  // list
  final RequestState listState;
  final List<NotificationModel> notifications;
  final String? listError;

  // pagination
  final int notificationsCurrentPage;
  final bool notificationsHasMore;
  final bool isLoadMoreNotifications;
  final int notificationsLimit;

  // details
  final RequestState detailsState;
  final NotificationModel? selectedNotification;
  final String? detailsError;
  final NotificationModel? lastReadNotification;

  // mark read
  final RequestState markReadState;
  final String? markReadLoadingId;
  final String? markReadError;

  const NotificationState({
    this.listState = RequestState.idle,
    this.notifications = const [],
    this.listError,
    this.notificationsCurrentPage = 1,
    this.notificationsHasMore = true,
    this.isLoadMoreNotifications = false,
    this.notificationsLimit = 20,
    this.detailsState = RequestState.idle,
    this.selectedNotification,
    this.detailsError,
    this.lastReadNotification,
    this.markReadState = RequestState.idle,
    this.markReadLoadingId,
    this.markReadError,
  });

  NotificationState copyWith({
    RequestState? listState,
    List<NotificationModel>? notifications,
    String? listError,
    int? notificationsCurrentPage,
    bool? notificationsHasMore,
    bool? isLoadMoreNotifications,
    int? notificationsLimit,
    RequestState? detailsState,
    NotificationModel? selectedNotification,
    String? detailsError,
    NotificationModel? lastReadNotification,
    RequestState? markReadState,
    String? markReadLoadingId,
    String? markReadError,
  }) {
    return NotificationState(
      listState: listState ?? this.listState,
      notifications: notifications ?? this.notifications,

      listError: listError ?? this.listError,

      notificationsCurrentPage: notificationsCurrentPage ?? this.notificationsCurrentPage,
      notificationsHasMore: notificationsHasMore ?? this.notificationsHasMore,
      isLoadMoreNotifications: isLoadMoreNotifications ?? this.isLoadMoreNotifications,
      notificationsLimit: notificationsLimit ?? this.notificationsLimit,

      detailsState: detailsState ?? this.detailsState,
      selectedNotification: selectedNotification ?? this.selectedNotification,
      detailsError: detailsError ?? this.detailsError,
      lastReadNotification: lastReadNotification ?? this.lastReadNotification,

      markReadState: markReadState ?? this.markReadState,
      markReadLoadingId: markReadLoadingId ?? this.markReadLoadingId,
      markReadError: markReadError ?? this.markReadError,
    );
  }

  @override
  List<Object?> get props => [
    listState,
    notifications,
    listError,
    notificationsCurrentPage,
    notificationsHasMore,
    isLoadMoreNotifications,
    notificationsLimit,
    detailsState,
    selectedNotification,
    detailsError,
    lastReadNotification,
    markReadState,
    markReadLoadingId,
    markReadError,
  ];
}
