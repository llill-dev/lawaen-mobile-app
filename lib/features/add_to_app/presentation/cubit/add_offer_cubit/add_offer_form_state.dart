part of 'add_offer_form_cubit.dart';

class AddOfferFormState extends Equatable {
  final int currentStep;
  final AddOfferParams params;
  final RequestState submitState;
  final AddOfferModel? addedOffer;
  final String? submitError;

  const AddOfferFormState({
    required this.currentStep,
    required this.params,
    this.submitState = RequestState.idle,
    this.addedOffer,
    this.submitError,
  });

  factory AddOfferFormState.initial() => AddOfferFormState(currentStep: 0, params: AddOfferParams.initial());

  AddOfferFormState copyWith({
    int? currentStep,
    AddOfferParams? params,
    RequestState? submitState,
    AddOfferModel? addedOffer,
    String? submitError,
  }) {
    return AddOfferFormState(
      currentStep: currentStep ?? this.currentStep,
      params: params ?? this.params,
      submitState: submitState ?? this.submitState,
      addedOffer: addedOffer ?? this.addedOffer,
      submitError: submitError,
    );
  }

  @override
  List<Object?> get props => [currentStep, params, submitState, addedOffer, submitError];
}
