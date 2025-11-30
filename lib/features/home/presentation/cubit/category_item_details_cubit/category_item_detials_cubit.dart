import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/features/home/data/models/category_item_model.dart';
import 'package:lawaen/features/home/data/repos/category_item_details_repo/category_item_details_repo.dart';

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
          ),
        );
      },
    );
  }

  void clearGlobalError() {
    emit(state.copyWith(globalError: null));
  }
}
