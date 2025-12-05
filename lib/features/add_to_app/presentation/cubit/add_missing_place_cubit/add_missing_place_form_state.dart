part of 'add_missing_place_form_cubit.dart';

class AddMissingPlaceFormState extends Equatable {
  final int currentStep;

  // Basic Info
  final String mainCategory;
  final String subCategory;
  final String name;
  final String description;

  // Contact Info
  final String phone;
  final String whatsapp;
  final String instagram;
  final String facebook;

  // Working Time
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;

  // Image
  final File? imageFile;

  const AddMissingPlaceFormState({
    required this.currentStep,
    required this.mainCategory,
    required this.subCategory,
    required this.name,
    required this.description,
    required this.phone,
    required this.whatsapp,
    required this.instagram,
    required this.facebook,
    this.startTime,
    this.endTime,
    this.imageFile,
  });

  AddMissingPlaceFormState copyWith({
    int? currentStep,
    String? mainCategory,
    String? subCategory,
    String? name,
    String? description,
    String? phone,
    String? whatsapp,
    String? instagram,
    String? facebook,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    File? imageFile,
  }) {
    return AddMissingPlaceFormState(
      currentStep: currentStep ?? this.currentStep,
      mainCategory: mainCategory ?? this.mainCategory,
      subCategory: subCategory ?? this.subCategory,
      name: name ?? this.name,
      description: description ?? this.description,
      phone: phone ?? this.phone,
      whatsapp: whatsapp ?? this.whatsapp,
      instagram: instagram ?? this.instagram,
      facebook: facebook ?? this.facebook,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      imageFile: imageFile ?? this.imageFile,
    );
  }

  @override
  List<Object?> get props => [
    currentStep,
    mainCategory,
    subCategory,
    name,
    description,
    phone,
    whatsapp,
    instagram,
    facebook,
    startTime,
    endTime,
    imageFile,
  ];
}
