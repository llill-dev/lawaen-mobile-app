part of 'add_offer_form_cubit.dart';

class AddOfferFormState extends Equatable {
  final int currentStep;
  final OfferParams params;

  const AddOfferFormState({
    required this.currentStep,
    required this.params,
  });

  factory AddOfferFormState.initial() => AddOfferFormState(
        currentStep: 0,
        params: OfferParams.initial(),
      );

  AddOfferFormState copyWith({
    int? currentStep,
    OfferParams? params,
  }) {
    return AddOfferFormState(
      currentStep: currentStep ?? this.currentStep,
      params: params ?? this.params,
    );
  }

  @override
  List<Object?> get props => [currentStep, params];
}
