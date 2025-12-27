import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/features/onboarding/data/models/onboarding_message_model.dart';
import 'package:lawaen/features/onboarding/data/repos/onboarding_repo.dart';

part 'onboarding_state.dart';

@Injectable()
class OnboardingCubit extends Cubit<OnboardingState> {
  final OnboardingRepo _repo;

  OnboardingCubit(this._repo) : super(const OnboardingState());

  Future<void> getAdminMessage() async {
    if (!state.messageShow) return;

    emit(state.copyWith(messageState: RequestState.loading, messageError: null, globalError: null));

    final result = await _repo.getAdminMessage();

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            messageState: RequestState.error,
            messageError: failure.errorMessage,
            globalError: failure.errorMessage,
          ),
        );
      },
      (message) {
        emit(state.copyWith(messageState: RequestState.success, message: message, messageError: null));
      },
    );
  }

  void dontShowMessageAgen() {
    emit(state.copyWith(messageShow: false));
  }

  void clearGlobalError() {
    emit(state.copyWith(globalError: null));
  }
}
