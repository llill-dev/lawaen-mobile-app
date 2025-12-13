import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/location_manager/location_service.dart';
import 'package:lawaen/features/explore/data/repos/explore_repo.dart';
import 'package:lawaen/features/home/data/models/category_details_model.dart';
import 'package:lawaen/features/home/presentation/params/get_category_details_params.dart';

part 'explore_state.dart';

@Injectable()
class ExploreCubit extends Cubit<ExploreState> {
  final ExploreRepo _exploreRepo;
  final LocationService _locationService;

  ExploreCubit(this._exploreRepo, this._locationService) : super(const ExploreState());

  Future<void> getExplore({bool isLoadMore = false, String? search}) async {
    if (isLoadMore) {
      if (!state.hasMore || state.isLoadMore) return;
      emit(state.copyWith(isLoadMore: true));
    } else {
      emit(
        state.copyWith(
          exploreState: RequestState.loading,
          exploreError: null,
          globalError: null,
          exploreItems: [],
          isLoadMore: false,
          currentPage: 1,
          hasMore: true,
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
      search: search ?? state.search,
    );

    final result = await _exploreRepo.getExplore(params);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            exploreState: RequestState.error,
            exploreError: failure.errorMessage,
            globalError: failure.errorMessage,
            isLoadMore: false,
          ),
        );
      },
      (newItems) {
        final updatedList = isLoadMore ? [...state.exploreItems, ...newItems] : newItems;
        emit(
          state.copyWith(
            exploreState: RequestState.success,
            exploreItems: updatedList,
            exploreError: null,
            isLoadMore: false,
            currentPage: newItems.isEmpty ? state.currentPage : state.currentPage + 1,
            hasMore: newItems.isNotEmpty,
          ),
        );
      },
    );
  }

  void clearGlobalError() {
    emit(state.copyWith(globalError: null));
  }
}
