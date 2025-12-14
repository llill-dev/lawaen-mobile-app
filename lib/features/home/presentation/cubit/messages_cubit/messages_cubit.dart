import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/models/error_model.dart';
import 'package:lawaen/app/core/params/pagination_params.dart';
import 'package:lawaen/features/home/data/models/message_api_reponse.dart';
import 'package:lawaen/features/home/data/repos/category_item_details_repo/category_item_details_repo.dart';

part 'messages_state.dart';

@injectable
class MessagesCubit extends Cubit<MessagesState> {
  final CategoryItemDetailsRepo repo;

  MessagesCubit(this.repo) : super(const MessagesState());

  static const int _limit = 10;

  /// Initial load
  Future<void> fetchMessages({required String secondCategoryId, required String itemId}) async {
    emit(state.copyWith(isLoading: true, error: null));

    final result = await repo.getMessages(
      secondCategoryId: secondCategoryId,
      itemId: itemId,
      params: PaginationParams(page: 1, limit: _limit),
    );

    result.fold(
      (ErrorModel error) {
        emit(state.copyWith(isLoading: false, error: error.errorMessage));
      },
      (MessageApiResponse response) {
        final messages = response.data ?? [];
        emit(
          state.copyWith(
            isLoading: false,
            messages: messages,
            page: response.page ?? 1,
            hasReachedMax: messages.length >= (response.total ?? messages.length),
          ),
        );
      },
    );
  }

  /// Load next page
  Future<void> loadMoreMessages({required String secondCategoryId, required String itemId}) async {
    if (state.isLoadingMore || state.hasReachedMax) return;

    emit(state.copyWith(isLoadingMore: true));

    final nextPage = state.page + 1;

    final result = await repo.getMessages(
      secondCategoryId: secondCategoryId,
      itemId: itemId,
      params: PaginationParams(page: nextPage, limit: _limit),
    );

    result.fold(
      (ErrorModel error) {
        emit(state.copyWith(isLoadingMore: false, error: error.errorMessage));
      },
      (MessageApiResponse response) {
        final newMessages = response.data ?? [];
        final allMessages = List<MessageModel>.from(state.messages)..addAll(newMessages);

        emit(
          state.copyWith(
            isLoadingMore: false,
            messages: allMessages,
            page: response.page ?? state.page,
            hasReachedMax: allMessages.length >= (response.total ?? allMessages.length),
          ),
        );
      },
    );
  }

  /// Optimistic message insert (used after sendFeedBack)
  void addLocalMessage(MessageModel message) {
    final updated = List<MessageModel>.from(state.messages)..insert(0, message);

    emit(state.copyWith(messages: updated));
  }

  void reset() {
    emit(const MessagesState());
  }
}
