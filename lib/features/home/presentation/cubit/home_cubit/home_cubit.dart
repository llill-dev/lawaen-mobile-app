import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/category_model.dart';
import '../../../data/models/city_model.dart';
import '../../../data/repos/home_repo/home_repo.dart';

part 'home_state.dart';

@Injectable()
class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;

  HomeCubit(this._homeRepo) : super(const HomeState());

  Future<void> initHome() async {
    getCities();
    getCategories();
  }

  // ────────────────────────────────────────────────
  // CITIES
  // ────────────────────────────────────────────────
  Future<void> getCities() async {
    emit(state.copyWith(citiesState: RequestState.loading, citiesError: null));

    final result = await _homeRepo.getCities();

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            citiesState: RequestState.error,
            citiesError: failure.errorMessage,
            globalError: failure.errorMessage,
          ),
        );
      },
      (cities) {
        emit(state.copyWith(citiesState: RequestState.success, cities: cities, citiesError: null));
      },
    );
  }

  // ────────────────────────────────────────────────
  // CATEGORIES
  // ────────────────────────────────────────────────
  Future<void> getCategories() async {
    emit(state.copyWith(categoriesState: RequestState.loading, categoriesError: null));

    final result = await _homeRepo.getCategories();

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            categoriesState: RequestState.error,
            categoriesError: failure.errorMessage,
            globalError: failure.errorMessage,
          ),
        );
      },
      (categories) {
        emit(state.copyWith(categoriesState: RequestState.success, categories: categories, categoriesError: null));
      },
    );
  }

  void clearGlobalError() {
    emit(state.copyWith(globalError: null));
  }
}
