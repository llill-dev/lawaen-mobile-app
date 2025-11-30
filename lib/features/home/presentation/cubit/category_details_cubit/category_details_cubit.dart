import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/utils/enums.dart';
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

  String? _mainCategoryId;
  String? _search;

  Timer? _debounceTimer;

  Future<void> initCategoryDetails({required String mainCategoryId, String? search}) async {
    _mainCategoryId = mainCategoryId;
    _search = search;

    emit(
      state.copyWith(
        categories: [],
        categoriesCurrentPage: 1,
        hasMore: true,
        isLoadingMore: false,
        categoryDetailsState: RequestState.loading,
      ),
    );

    await _fetchCategoryDetails(isLoadMore: false);
  }

  Future<void> selectSecondCategory(String? secondCategoryId) async {
    final bool reset = secondCategoryId == null;

    emit(
      state.copyWith(
        resetSelectedSecondCategoryId: reset,
        selectedSecondCategoryId: secondCategoryId,
        categories: [],
        categoriesCurrentPage: 1,
        hasMore: true,
        isLoadingMore: false,
        categoryDetailsState: RequestState.loading,
      ),
    );

    await _fetchCategoryDetails(isLoadMore: false);
  }

  Future<void> _fetchCategoryDetails({required bool isLoadMore}) async {
    if (_mainCategoryId == null) return;

    if (!isLoadMore) {
      emit(state.copyWith(categoryDetailsState: RequestState.loading, categoriesError: null, globalError: null));
    }

    final location = await getIt<LocationService>().getBestEffortLocation();

    final params = GetCategoryDetailsParams(
      latitude: location.latitude,
      longitude: location.longitude,
      limit: state.limit,
      page: state.categoriesCurrentPage,
      search: _search,
    );

    final bool useSecond = state.selectedSecondCategoryId != null;

    final String idToSend = useSecond ? state.selectedSecondCategoryId! : _mainCategoryId!;

    final result = await _categoryDetailsRepo.getCategoryDetails(idToSend, params, useSecondCategory: useSecond);

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

  void loadMoreDebounced() {
    if (!state.hasMore || state.isLoadingMore) return;

    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 250), () {
      loadMore();
    });
  }

  Future<void> loadMore() async {
    if (_mainCategoryId == null) return;

    if (!state.hasMore || state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));

    await _fetchCategoryDetails(isLoadMore: true);
  }

  Future<void> refresh() async {
    if (_mainCategoryId == null) return;

    emit(
      state.copyWith(
        categories: [],
        categoriesCurrentPage: 1,
        hasMore: true,
        isLoadingMore: false,
        categoryDetailsState: RequestState.loading,
      ),
    );

    await _fetchCategoryDetails(isLoadMore: false);
  }

  void clearGlobalError() {
    emit(state.copyWith(globalError: null));
  }
}
