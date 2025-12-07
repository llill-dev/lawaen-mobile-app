part of 'add_event_form_cubit.dart';

class AddEventFormState extends Equatable {
  final int currentStep;
  final AddEventParams params;
  final RequestState submitState;
  final AddEventModel? addedEvent;
  final String? submitError;

  const AddEventFormState({
    required this.currentStep,
    required this.params,
    this.submitState = RequestState.idle,
    this.addedEvent,
    this.submitError,
  });

  factory AddEventFormState.initial() => AddEventFormState(currentStep: 0, params: AddEventParams.initial());

  AddEventFormState copyWith({
    int? currentStep,
    AddEventParams? params,
    RequestState? submitState,
    AddEventModel? addedEvent,
    String? submitError,
  }) {
    return AddEventFormState(
      currentStep: currentStep ?? this.currentStep,
      params: params ?? this.params,
      submitState: submitState ?? this.submitState,
      addedEvent: addedEvent ?? this.addedEvent,
      submitError: submitError,
    );
  }

  @override
  List<Object?> get props => [currentStep, params, submitState, addedEvent, submitError];
}
