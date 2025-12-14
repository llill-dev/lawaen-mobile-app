part of 'messages_cubit.dart';

class MessagesState extends Equatable {
  final List<MessageModel> messages;
  final bool isLoading;
  final bool isLoadingMore;
  final int page;
  final bool hasReachedMax;
  final String? error;

  final bool isSending;
  final String? sendError;

  const MessagesState({
    this.messages = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.page = 1,
    this.hasReachedMax = false,
    this.error,
    this.isSending = false,
    this.sendError,
  });

  MessagesState copyWith({
    List<MessageModel>? messages,
    bool? isLoading,
    bool? isLoadingMore,
    int? page,
    bool? hasReachedMax,
    String? error,
    bool? isSending,
    String? sendError,
  }) {
    return MessagesState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error,
      isSending: isSending ?? this.isSending,
      sendError: sendError,
    );
  }

  @override
  List<Object?> get props => [messages, isLoading, isLoadingMore, page, hasReachedMax, error, isSending, sendError];
}
