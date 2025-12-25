part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  // list
  final RequestState listState;
  final List<NotificationModel> notifications;
  final String? listError;

  // details
  final RequestState detailsState;
  final NotificationModel? selectedNotification;
  final String? detailsError;

  // mark read
  final RequestState markReadState;
  final String? markReadError;

  const NotificationState({
    this.listState = RequestState.idle,
    this.notifications = const [],
    this.listError,
    this.detailsState = RequestState.idle,
    this.selectedNotification,
    this.detailsError,
    this.markReadState = RequestState.idle,
    this.markReadError,
  });

  NotificationState copyWith({
    RequestState? listState,
    List<NotificationModel>? notifications,
    String? listError,
    RequestState? detailsState,
    NotificationModel? selectedNotification,
    String? detailsError,
    RequestState? markReadState,
    String? markReadError,
  }) {
    return NotificationState(
      listState: listState ?? this.listState,
      notifications: notifications ?? this.notifications,
      listError: listError,
      detailsState: detailsState ?? this.detailsState,
      selectedNotification: selectedNotification,
      detailsError: detailsError,
      markReadState: markReadState ?? this.markReadState,
      markReadError: markReadError,
    );
  }

  @override
  List<Object?> get props => [
    listState,
    notifications,
    listError,
    detailsState,
    selectedNotification,
    detailsError,
    markReadState,
    markReadError,
  ];
}
