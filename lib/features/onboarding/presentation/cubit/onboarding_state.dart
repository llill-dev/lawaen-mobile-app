part of 'onboarding_cubit.dart';

class OnboardingState extends Equatable {
  final RequestState messageState;
  final OnboardingMessageModel? message;
  final String? messageError;

  final String? globalError;

  const OnboardingState({this.messageState = RequestState.idle, this.message, this.messageError, this.globalError});

  OnboardingState copyWith({
    RequestState? messageState,
    OnboardingMessageModel? message,
    String? messageError,
    String? globalError,
  }) {
    return OnboardingState(
      messageState: messageState ?? this.messageState,
      message: message ?? this.message,
      messageError: messageError,
      globalError: globalError,
    );
  }

  @override
  List<Object?> get props => [messageState, message, messageError, globalError];
}
