part of 'add_missing_place_form_cubit.dart';

class AddMissingPlaceFormState extends Equatable {
  final int currentStep;
  final AddMissingPlaceParams params;
  final RequestState submitState;
  final AddMissingPlcaeModel? addedPlace;
  final String? submitError;

  const AddMissingPlaceFormState({
    required this.currentStep,
    required this.params,
    this.submitState = RequestState.idle,
    this.addedPlace,
    this.submitError,
  });

  factory AddMissingPlaceFormState.initial() =>
      AddMissingPlaceFormState(currentStep: 0, params: AddMissingPlaceParams.initial());

  AddMissingPlaceFormState copyWith({
    int? currentStep,
    AddMissingPlaceParams? params,
    RequestState? submitState,
    AddMissingPlcaeModel? addedPlace,
    String? submitError,
  }) {
    return AddMissingPlaceFormState(
      currentStep: currentStep ?? this.currentStep,
      params: params ?? this.params,
      submitState: submitState ?? this.submitState,
      addedPlace: addedPlace ?? this.addedPlace,
      submitError: submitError,
    );
  }

  @override
  List<Object?> get props => [currentStep, params, submitState, addedPlace, submitError];
}
