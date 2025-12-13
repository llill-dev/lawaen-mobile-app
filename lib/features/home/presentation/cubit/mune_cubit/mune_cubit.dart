import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/features/home/data/models/mune_model.dart';
import 'package:lawaen/features/home/data/repos/home_repo/home_repo.dart';
import 'package:lawaen/features/home/presentation/params/get_menu_params.dart';

part 'mune_state.dart';

@Injectable()
class MuneCubit extends Cubit<MuneState> {
  final HomeRepo _homeRepo;

  MuneCubit(this._homeRepo) : super(const MuneState());

  Future<void> getMune(GetMenuParams params) async {
    emit(state.copyWith(muneState: RequestState.loading, muneError: null, globalError: null));

    final result = await _homeRepo.getMune(params);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            muneState: RequestState.error,
            muneError: failure.errorMessage,
            globalError: failure.errorMessage,
          ),
        );
      },
      (mune) {
        emit(
          state.copyWith(
            muneState: RequestState.success,
            mune: mune,
            muneError: null,
          ),
        );
      },
    );
  }

  void clearGlobalError() {
    emit(state.copyWith(globalError: null));
  }
}
