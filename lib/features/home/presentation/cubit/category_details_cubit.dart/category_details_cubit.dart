import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/location_manager/location_service.dart';
import 'package:lawaen/features/home/data/models/category_details_model.dart';
import 'package:lawaen/features/home/data/repos/category_details_repo/cetagory_details_repo.dart';
import 'package:lawaen/features/home/presentation/params/get_category_details_params.dart';

part 'category_details_state.dart';

@Injectable()
class CategoryDetailsCubit extends Cubit<CategoryDetailsState> {
  final CategoryDetailsRepo _categoryDetailsRepo;

  CategoryDetailsCubit(this._categoryDetailsRepo) : super(const CategoryDetailsState());

  Future<void> getCategoryDetails({required String mainCategoryId, String? search, required bool isLoadMore}) async {
    if (!isLoadMore) {
      emit(state.copyWith(categoryDetailsState: RequestState.loading, categoriesError: null));
    }

    final location = await getIt<LocationService>().getBestEffortLocation();

    final params = GetCategoryDetailsParams(
      latitude: location.latitude,
      longitude: location.longitude,
      search: search,
      limit: state.limit,
      page: state.categoriesCurrentPage,
    );

    final result = await _categoryDetailsRepo.getCategoryDetails(mainCategoryId, params);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            categoryDetailsState: RequestState.error,
            categoriesError: failure.errorMessage,
            globalError: failure.errorMessage,
            isLoadingMore: false,
          ),
        );
      },
      (newItems) {
        final updatedList = isLoadMore ? [...state.categories, ...newItems] : newItems;

        emit(
          state.copyWith(
            categoryDetailsState: RequestState.success,
            categories: updatedList,
            isLoadingMore: false,
            categoriesCurrentPage: newItems.isEmpty ? state.categoriesCurrentPage : state.categoriesCurrentPage + 1,
            hasMore: newItems.isNotEmpty,
          ),
        );
      },
    );
  }

  Future<void> loadMore({required String mainCategoryId, String? search}) async {
    if (!state.hasMore || state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));

    await getCategoryDetails(mainCategoryId: mainCategoryId, search: search, isLoadMore: true);
  }

  void clearGlobalError() {
    emit(state.copyWith(globalError: null));
  }
}
