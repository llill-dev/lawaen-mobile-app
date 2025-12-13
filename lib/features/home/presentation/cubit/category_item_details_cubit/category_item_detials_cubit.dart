import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/features/home/data/models/category_item_model.dart';
import 'package:lawaen/features/home/data/repos/category_item_details_repo/category_item_details_repo.dart';
import 'package:lawaen/features/home/presentation/params/rate_item_params.dart';

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

  void clearGlobalError() {
    emit(state.copyWith(globalError: null));
  }
}
