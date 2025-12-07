part of 'add_missing_place_form_cubit.dart';

class AddMissingPlaceFormState extends Equatable {
  final int currentStep;
  final AddMissingPlaceParams params;

  const AddMissingPlaceFormState({required this.currentStep, required this.params});

  factory AddMissingPlaceFormState.initial() =>
      AddMissingPlaceFormState(currentStep: 0, params: AddMissingPlaceParams.initial());

  AddMissingPlaceFormState copyWith({int? currentStep, AddMissingPlaceParams? params}) {
    return AddMissingPlaceFormState(currentStep: currentStep ?? this.currentStep, params: params ?? this.params);
  }

  @override
  List<Object?> get props => [currentStep, params];
}
