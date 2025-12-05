part of 'add_event_form_cubit.dart';

class AddEventFormState extends Equatable {
  final int currentStep;

  // Basic info
  final String eventType;
  final String name;
  final String description;

  // Contact
  final String phone;
  final String whatsapp;
  final String instagram;
  final String facebook;

  // Booking
  final String bookingMethod;
  final String price;
  final String bookingFee;
  final String organiserLink;

  // Working time & date
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final DateTime? startDate;
  final DateTime? endDate;
  final String eventTime;

  // Image
  final File? imageFile;

  // Location
  final double? latitude;
  final double? longitude;

  const AddEventFormState({
    required this.currentStep,
    required this.eventType,
    required this.name,
    required this.description,
    required this.phone,
    required this.whatsapp,
    required this.instagram,
    required this.facebook,
    required this.bookingMethod,
    required this.price,
    required this.bookingFee,
    required this.organiserLink,
    this.startTime,
    this.endTime,
    this.startDate,
    this.endDate,
    this.eventTime = '',
    this.imageFile,
    this.latitude,
    this.longitude,
  });

  AddEventFormState copyWith({
    int? currentStep,
    String? eventType,
    String? name,
    String? description,
    String? phone,
    String? whatsapp,
    String? instagram,
    String? facebook,
    String? bookingMethod,
    String? price,
    String? bookingFee,
    String? organiserLink,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    DateTime? startDate,
    DateTime? endDate,
    String? eventTime,
    File? imageFile,
    double? latitude,
    double? longitude,
  }) {
    return AddEventFormState(
      currentStep: currentStep ?? this.currentStep,
      eventType: eventType ?? this.eventType,
      name: name ?? this.name,
      description: description ?? this.description,
      phone: phone ?? this.phone,
      whatsapp: whatsapp ?? this.whatsapp,
      instagram: instagram ?? this.instagram,
      facebook: facebook ?? this.facebook,
      bookingMethod: bookingMethod ?? this.bookingMethod,
      price: price ?? this.price,
      bookingFee: bookingFee ?? this.bookingFee,
      organiserLink: organiserLink ?? this.organiserLink,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      eventTime: eventTime ?? this.eventTime,
      imageFile: imageFile ?? this.imageFile,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  List<Object?> get props => [
    currentStep,
    eventType,
    name,
    description,
    phone,
    whatsapp,
    instagram,
    facebook,
    bookingMethod,
    price,
    bookingFee,
    organiserLink,
    startTime,
    endTime,
    startDate,
    endDate,
    eventTime,
    imageFile,
    latitude,
    longitude,
  ];
}
