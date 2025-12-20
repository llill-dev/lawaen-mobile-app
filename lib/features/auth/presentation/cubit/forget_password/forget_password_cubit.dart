import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/features/auth/data/repo/auth_repo.dart';
import 'package:lawaen/features/auth/presentation/params/forget_password_params.dart';
import 'package:lawaen/features/auth/presentation/params/otp_verification_params.dart';
import 'package:lawaen/features/auth/presentation/params/reset_password_params.dart';

part 'forget_password_state.dart';

@Injectable()
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final AuthRepo _authRepo;

  ForgetPasswordCubit(this._authRepo) : super(const ForgetPasswordState());

  Future<void> sendForgetRequest(String contact) async {
    final trimmedContact = contact.trim();
    emit(
      state.copyWith(
        forgotState: RequestState.loading,
        forgotError: null,
        globalError: null,
        contact: trimmedContact,
      ),
    );

    final params = _buildForgetParams(trimmedContact);

    final result = await _authRepo.forgotPassword(params);
    result.fold(
      (error) => emit(
        state.copyWith(
          forgotState: RequestState.error,
          forgotError: error.errorMessage,
          globalError: error.errorMessage,
        ),
      ),
      (_) => emit(state.copyWith(forgotState: RequestState.success, forgotError: null)),
    );
  }

  Future<void> sendOtpVerification(String contact, String passcode) async {
    final trimmedContact = contact.trim();
    emit(
      state.copyWith(
        verifyState: RequestState.loading,
        verifyError: null,
        globalError: null,
        contact: trimmedContact,
        passcode: passcode,
      ),
    );

    final params = _buildOtpParams(trimmedContact, passcode);

    final result = await _authRepo.sendPasscode(params);
    result.fold(
      (error) => emit(
        state.copyWith(
          verifyState: RequestState.error,
          verifyError: error.errorMessage,
          globalError: error.errorMessage,
        ),
      ),
      (_) => emit(state.copyWith(verifyState: RequestState.success, verifyError: null)),
    );
  }

  Future<void> resetPassword(String contact, String password) async {
    final trimmedContact = contact.trim();
    emit(
      state.copyWith(
        resetState: RequestState.loading,
        resetError: null,
        globalError: null,
        contact: trimmedContact,
      ),
    );

    final params = _buildResetParams(trimmedContact, password);

    final result = await _authRepo.resetPassword(params);
    result.fold(
      (error) => emit(
        state.copyWith(
          resetState: RequestState.error,
          resetError: error.errorMessage,
          globalError: error.errorMessage,
        ),
      ),
      (_) => emit(state.copyWith(resetState: RequestState.success, resetError: null)),
    );
  }

  ForgetPasswordParams _buildForgetParams(String contact) {
    final isEmail = contact.contains('@');
    return ForgetPasswordParams(email: isEmail ? contact : null, phone: isEmail ? null : contact);
  }

  OtpVerificationParams _buildOtpParams(String contact, String passcode) {
    final isEmail = contact.contains('@');
    return OtpVerificationParams(email: isEmail ? contact : null, phone: isEmail ? null : contact, passcode: passcode);
  }

  ResetPasswordParams _buildResetParams(String contact, String password) {
    final isEmail = contact.contains('@');
    return ResetPasswordParams(email: isEmail ? contact : null, phone: isEmail ? null : contact, password: password);
  }
}
