import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/features/auth/data/models/user_model.dart';
import 'package:lawaen/features/auth/data/repo/auth_repo.dart';
import 'package:lawaen/features/auth/presentation/params/update_profile_params.dart';

part 'update_profile_cubit_state.dart';

@Injectable()
class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final AuthRepo _authRepo;

  UpdateProfileCubit(this._authRepo) : super(const UpdateProfileState());

  Future<void> updateProfile(UpdateProfileParams params) async {
    emit(state.copyWith(updateState: RequestState.loading, updateError: null));

    final result = await _authRepo.updateProfile(params);

    result.fold(
      (failure) {
        log("Update profile error: ${failure.errorMessage}");
        emit(state.copyWith(updateState: RequestState.error, updateError: failure.errorMessage));
      },
      (user) {
        emit(state.copyWith(updateState: RequestState.success, user: user, updateError: null));
      },
    );
  }
}
