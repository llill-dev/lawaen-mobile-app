import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/location_manager/location_service.dart';
import 'package:lawaen/features/home/data/models/category_details_model.dart';
import 'package:lawaen/features/home/data/models/category_model.dart';
import 'package:lawaen/features/home/presentation/params/get_category_details_params.dart';
import 'package:lawaen/features/nearby/data/repos/map_repo.dart';

part 'map_state.dart';

@Injectable()
class MapCubit extends Cubit<MapState> {
  final MapRepo _mapRepo;
  final LocationService _locationService;

  MapCubit(this._mapRepo, this._locationService) : super(const MapState());

  // ===================================================
  // INIT MAP
  // ===================================================
  Future<void> initMap() async {
    emit(state.copyWith(itemsState: RequestState.loading));

    final location = await _locationService.getBestEffortLocation();

    emit(state.copyWith(userLatitude: location.latitude, userLongitude: location.longitude));

    await _loadInitialItems();
  }

  Future<void> _loadInitialItems() async {
    if (state.userLatitude == null || state.userLongitude == null) return;

    emit(state.copyWith(itemsState: RequestState.loading));

    final params = GetCategoryDetailsParams(
      latitude: state.userLatitude!,
      longitude: state.userLongitude!,
      limit: 50,
      page: 1,
      search: state.searchQuery.isEmpty ? null : state.searchQuery,
    );

    final result = await _mapRepo.getInitialItems(params);

    result.fold(
      (failure) {
        emit(state.copyWith(itemsState: RequestState.error, itemsError: failure.errorMessage));
      },
      (items) {
        emit(state.copyWith(itemsState: RequestState.success, items: items, itemsError: null));
      },
    );
  }

  // ===================================================
  // LOAD CATEGORIES
  // ===================================================
  Future<void> expandSheet(bool expanded) async {
    emit(state.copyWith(isSheetExpanded: expanded));

    if (expanded && state.categories.isEmpty) {
      await _loadCategories();
    }
  }

  Future<void> _loadCategories() async {
    emit(state.copyWith(categoriesState: RequestState.loading));

    final result = await _mapRepo.getCategories();

    result.fold(
      (failure) {
        emit(state.copyWith(categoriesState: RequestState.error, categoriesError: failure.errorMessage));
      },
      (categories) {
        emit(state.copyWith(categoriesState: RequestState.success, categories: categories, categoriesError: null));
      },
    );
  }

  // ===================================================
  // FILTER BY CATEGORY
  // ===================================================
  Future<void> selectCategory(String? categoryId) async {
    emit(state.copyWith(selectedCategoryId: categoryId));

    if (categoryId == null) {
      await _loadInitialItems();
      return;
    }

    await _loadItemsByCategory(categoryId);
  }

  Future<void> _loadItemsByCategory(String categoryId) async {
    emit(state.copyWith(itemsState: RequestState.loading));

    final params = GetCategoryDetailsParams(
      latitude: state.userLatitude!,
      longitude: state.userLongitude!,
      limit: 50,
      page: 1,
      search: state.searchQuery.isEmpty ? null : state.searchQuery,
    );

    final result = await _mapRepo.getItemsByCategory(categoryId, params);

    result.fold(
      (failure) {
        emit(state.copyWith(itemsState: RequestState.error, itemsError: failure.errorMessage));
      },
      (items) {
        emit(state.copyWith(itemsState: RequestState.success, items: items, itemsError: null));
      },
    );
  }

  // ===================================================
  // SEARCH FILTER
  // ===================================================
  Future<void> updateSearch(String text) async {
    emit(state.copyWith(searchQuery: text));

    await _loadInitialItems();
  }
}
