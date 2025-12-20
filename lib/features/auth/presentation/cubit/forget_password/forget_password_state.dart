part of 'forget_password_cubit.dart';

class ForgetPasswordState extends Equatable {
  final RequestState forgotState;
  final RequestState verifyState;
  final RequestState resetState;
  final String? forgotError;
  final String? verifyError;
  final String? resetError;
  final String? globalError;
  final String? contact;
  final String? passcode;

  const ForgetPasswordState({
    this.forgotState = RequestState.idle,
    this.verifyState = RequestState.idle,
    this.resetState = RequestState.idle,
    this.forgotError,
    this.verifyError,
    this.resetError,
    this.globalError,
    this.contact,
    this.passcode,
  });

  ForgetPasswordState copyWith({
    RequestState? forgotState,
    RequestState? verifyState,
    RequestState? resetState,
    String? forgotError,
    String? verifyError,
    String? resetError,
    String? globalError,
    String? contact,
    String? passcode,
  }) {
    return ForgetPasswordState(
      forgotState: forgotState ?? this.forgotState,
      verifyState: verifyState ?? this.verifyState,
      resetState: resetState ?? this.resetState,
      forgotError: forgotError,
      verifyError: verifyError,
      resetError: resetError,
      globalError: globalError,
      contact: contact ?? this.contact,
      passcode: passcode ?? this.passcode,
    );
  }

  @override
  List<Object?> get props => [
        forgotState,
        verifyState,
        resetState,
        forgotError,
        verifyError,
        resetError,
        globalError,
        contact,
        passcode,
      ];
}
