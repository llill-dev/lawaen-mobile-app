import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/features/home/data/models/category_item_model.dart';
import 'package:lawaen/features/home/data/models/claim_item_model.dart';
import 'package:lawaen/features/home/data/repos/category_item_details_repo/category_item_details_repo.dart';
import 'package:lawaen/features/home/presentation/params/claim_item.params.dart';
import 'package:lawaen/features/home/presentation/params/rate_item_params.dart';
import 'package:lawaen/features/home/presentation/params/report_item_params.dart';
import 'package:lawaen/features/home/presentation/params/send_feed_back_params.dart';

part 'category_item_detials_state.dart';

@Injectable()
class CategoryItemDetialsCubit extends Cubit<CategoryItemDetialsState> {
  final CategoryItemDetailsRepo _categoryItemDetailsRepo;
  CategoryItemDetialsCubit(this._categoryItemDetailsRepo) : super(CategoryItemDetialsState());

  void getCategoryItems({required String itemId, required String secondCategoryId}) async {
    emit(state.copyWith(categoryItemState: RequestState.loading));

    final result = await _categoryItemDetailsRepo.getCategoryItems(itemId: itemId, secondCategoryId: secondCategoryId);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            categoryItemState: RequestState.error,
            categoryItemsError: failure.errorMessage,
            globalError: failure.errorMessage,
          ),
        );
      },
      (categoryItems) {
        emit(
          state.copyWith(
            categoryItemState: RequestState.success,
            categoryItems: categoryItems,
            categoryItemsError: null,
            globalError: null,
          ),
        );
      },
    );
  }

  void toggleFavorite({required String itemId, required String secondCategoryId}) async {
    emit(state.copyWith(toggleFavoriteState: RequestState.loading));

    final result = await _categoryItemDetailsRepo.toggleFavorite(itemId: itemId, secondCategoryId: secondCategoryId);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            toggleFavoriteState: RequestState.error,
            toggleFavoriteError: failure.errorMessage,
            globalError: failure.errorMessage,
          ),
        );
      },
      (toggleModel) {
        emit(
          state.copyWith(
            toggleFavoriteState: RequestState.success,
            saved: toggleModel.saved,
            toggleFavoriteError: null,
            globalError: null,
          ),
        );
      },
    );
  }

  void rateItem({required String itemId, required String secondCategoryId, required RateItemParams params}) async {
    emit(state.copyWith(rateItemState: RequestState.loading));

    final result = await _categoryItemDetailsRepo.reateItem(
      itemId: itemId,
      secondCategoryId: secondCategoryId,
      params: params,
    );
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            rateItemState: RequestState.error,
            rateItemError: failure.errorMessage,
            globalError: failure.errorMessage,
          ),
        );
      },
      (_) {
        emit(state.copyWith(rateItemState: RequestState.success, rateItemError: null, globalError: null));
      },
    );
  }

  void sendFeedBack({
    required String itemId,
    required String secondCategoryId,
    required SendFeedBackParams params,
  }) async {
    emit(state.copyWith(sendFeedBackState: RequestState.loading));

    final result = await _categoryItemDetailsRepo.sendFeedBack(
      itemId: itemId,
      secondCategoryId: secondCategoryId,
      params: params,
    );
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            sendFeedBackState: RequestState.error,
            sendFeedBackError: failure.errorMessage,
            globalError: failure.errorMessage,
          ),
        );
      },
      (_) {
        emit(state.copyWith(sendFeedBackState: RequestState.success, sendFeedBackError: null, globalError: null));
      },
    );
  }

  void claimItem({
    required String itemId,
    required String secondCategoryId,
    String? note,
    String? phone,
    List<File>? images,
  }) async {
    emit(state.copyWith(claimItemState: RequestState.loading));

    final result = await _categoryItemDetailsRepo.claimItem(
      itemId: itemId,
      secondCategoryId: secondCategoryId,
      params: ClaimItemParams(note: note, phone: phone, images: images),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            claimItemState: RequestState.error,
            claimItemError: failure.errorMessage,
            globalError: failure.errorMessage,
          ),
        );
      },
      (claimItem) {
        emit(
          state.copyWith(
            claimItemState: RequestState.success,
            claimItem: claimItem,
            claimItemError: null,
            globalError: null,
          ),
        );
      },
    );
  }

  void reportItem({required String itemId, required String secondCategoryId, required ReportItemParams params}) async {
    emit(state.copyWith(reportItemState: RequestState.loading));

    final result = await _categoryItemDetailsRepo.reportItem(
      itemId: itemId,
      secondCategoryId: secondCategoryId,
      params: params,
    );
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            reportItemState: RequestState.error,
            reportItemError: failure.errorMessage,
            globalError: failure.errorMessage,
          ),
        );
      },
      (_) {
        emit(state.copyWith(reportItemState: RequestState.success, reportItemError: null, globalError: null));
      },
    );
  }

  void clearGlobalError() {
    emit(state.copyWith(globalError: null));
  }
}
