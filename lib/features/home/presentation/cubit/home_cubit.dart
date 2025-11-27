import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/features/home/data/models/city_model.dart';
import 'package:lawaen/features/home/data/repos/home_repo.dart';

part 'home_state.dart';

@Injectable()
class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;
  HomeCubit(this._homeRepo) : super(HomeInitial());

  Future<void> getCities() async {
    emit(GetCitiesLoading());
    final result = await _homeRepo.getCities();
    result.fold(
      (error) => emit(GetCitiesError(errorMessage: error.errorMessage)),
      (cities) => emit(GetCitiesSuccess(cities: cities)),
    );
  }
}
