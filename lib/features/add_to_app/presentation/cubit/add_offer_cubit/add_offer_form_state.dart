part of 'add_offer_form_cubit.dart';

class AddOfferFormState extends Equatable {
  final int currentStep;

  // Basic info
  final String name;
  final String description;

  // Contact info
  final String phone;
  final String whatsapp;

  final File? imageFile;

  const AddOfferFormState({
    required this.currentStep,
    required this.name,
    required this.description,
    required this.phone,
    required this.whatsapp,
    this.imageFile,
  });

  AddOfferFormState copyWith({
    int? currentStep,
    String? name,
    String? description,
    String? phone,
    String? whatsapp,
    File? imageFile,
  }) {
    return AddOfferFormState(
      imageFile: imageFile ?? this.imageFile,
      currentStep: currentStep ?? this.currentStep,
      name: name ?? this.name,
      description: description ?? this.description,
      phone: phone ?? this.phone,
      whatsapp: whatsapp ?? this.whatsapp,
    );
  }

  @override
  List<Object?> get props => [currentStep, name, description, phone, whatsapp];
}
