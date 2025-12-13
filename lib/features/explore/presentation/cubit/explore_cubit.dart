import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/location_manager/location_service.dart';
import 'package:lawaen/features/explore/data/models/user_preferences_model.dart';
import 'package:lawaen/features/explore/data/repos/explore_repo.dart';
import 'package:lawaen/features/home/data/models/category_details_model.dart';
import 'package:lawaen/features/home/presentation/params/get_category_details_params.dart';

part 'explore_state.dart';

@singleton
class ExploreCubit extends Cubit<ExploreState> {
  final ExploreRepo _exploreRepo;
  final LocationService _locationService;

  ExploreCubit(this._exploreRepo, this._locationService) : super(const ExploreState());

  Future<void> getExplore({bool isLoadMore = false, String? search}) async {
    if (state.preferencesState == RequestState.idle) {
      await getUserPreferences();
    }
    if (state.userPreferences.isEmpty) return;

    final categoryId = state.selectedCategoryId ?? state.userPreferences.first.id;

    if (isLoadMore) {
      if (!state.hasMore || state.isLoadMore) return;
      emit(state.copyWith(isLoadMore: true));
    } else {
      emit(
        state.copyWith(
          exploreState: RequestState.loading,
          exploreItems: [],
          exploreError: null,
          globalError: null,
          currentPage: 1,
          hasMore: true,
          isLoadMore: false,
          search: search,
        ),
      );
    }

    final location = await _locationService.getBestEffortLocation();

    final params = GetCategoryDetailsParams(
      cityId: location.cityId ?? "",
      latitude: location.latitude,
      longitude: location.longitude,
      limit: state.limit,
      page: state.currentPage,
      search: search,
    );

    final result = await _exploreRepo.getExplore(params, categoryId);

    result.fold(
      (failure) {
        emit(state.copyWith(exploreState: RequestState.error, exploreError: failure.errorMessage, isLoadMore: false));
      },
      (newItems) {
        emit(
          state.copyWith(
            exploreState: RequestState.success,
            exploreItems: isLoadMore ? [...state.exploreItems, ...newItems] : newItems,
            isLoadMore: false,
            currentPage: newItems.isEmpty ? state.currentPage : state.currentPage + 1,
            hasMore: newItems.isNotEmpty,
          ),
        );
      },
    );
  }

  Future<void> getUserPreferences() async {
    emit(state.copyWith(preferencesState: RequestState.loading, preferencesError: null, globalError: null));

    final result = await _exploreRepo.getUserPreferences();

    result.fold(
      (failure) {
        emit(state.copyWith(preferencesState: RequestState.error, preferencesError: failure.errorMessage));
      },
      (preferences) {
        final shouldSetCategory = state.selectedCategoryId == null && preferences.isNotEmpty;

        emit(
          state.copyWith(
            preferencesState: RequestState.success,
            userPreferences: preferences,
            preferencesError: null,
            selectedCategoryId: shouldSetCategory ? preferences.first.id : state.selectedCategoryId,
          ),
        );
      },
    );
  }

  void selectCategory(String categoryId) {
    if (state.selectedCategoryId == categoryId) return;

    emit(state.copyWith(selectedCategoryId: categoryId, currentPage: 1, hasMore: true, exploreItems: [], search: null));

    getExplore(isLoadMore: false, search: null);
  }

  void clearGlobalError() {
    emit(state.copyWith(globalError: null));
  }
}
