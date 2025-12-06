part of 'add_event_form_cubit.dart';

class AddEventFormState extends Equatable {
  final int currentStep;
  final EventParams params;

  const AddEventFormState({required this.currentStep, required this.params});

  factory AddEventFormState.initial() => AddEventFormState(currentStep: 0, params: EventParams.initial());

  AddEventFormState copyWith({int? currentStep, EventParams? params}) {
    return AddEventFormState(currentStep: currentStep ?? this.currentStep, params: params ?? this.params);
  }

  @override
  List<Object?> get props => [currentStep, params];
}
