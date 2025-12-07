part of 'add_offer_form_cubit.dart';

class AddOfferFormState extends Equatable {
  final int currentStep;
  final AddOfferParams params;

  const AddOfferFormState({required this.currentStep, required this.params});

  factory AddOfferFormState.initial() => AddOfferFormState(currentStep: 0, params: AddOfferParams.initial());

  AddOfferFormState copyWith({int? currentStep, AddOfferParams? params}) {
    return AddOfferFormState(currentStep: currentStep ?? this.currentStep, params: params ?? this.params);
  }

  @override
  List<Object?> get props => [currentStep, params];
}
