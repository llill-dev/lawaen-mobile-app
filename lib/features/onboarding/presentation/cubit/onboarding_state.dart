part of 'onboarding_cubit.dart';

class OnboardingState extends Equatable {
  final RequestState messageState;
  final OnboardingMessageModel? message;
  final String? messageError;
  final bool messageShow;

  final String? globalError;

  const OnboardingState({
    this.messageState = RequestState.idle,
    this.message,
    this.messageError,
    this.globalError,
    this.messageShow = true,
  });

  OnboardingState copyWith({
    RequestState? messageState,
    OnboardingMessageModel? message,
    String? messageError,
    bool? messageShow,
    String? globalError,
  }) {
    return OnboardingState(
      messageState: messageState ?? this.messageState,
      message: message ?? this.message,
      messageError: messageError,
      messageShow: messageShow ?? this.messageShow,
      globalError: globalError,
    );
  }

  @override
  List<Object?> get props => [messageState, message, messageError, globalError, messageShow];
}
