import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:lawaen/features/add_to_app/presentation/params/contact_info.dart';
import 'package:lawaen/features/add_to_app/presentation/params/location_info.dart';

part 'add_event_params.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class AddEventParams {
  @JsonKey(name: 'event_type')
  final String? eventType;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'description')
  final String? description;

  final ContactInfo contact;

  @JsonKey(name: 'booking_method')
  final String? bookingMethod;

  @JsonKey(name: 'price')
  final String? price;

  @JsonKey(name: 'organization')
  final String? organization;

  @JsonKey(name: 'start_time')
  final String? startTime;

  @JsonKey(name: 'end_time')
  final String? endTime;

  @JsonKey(name: 'start_date')
  final String? startDate;

  @JsonKey(name: 'end_date')
  final String? endDate;

  @JsonKey(name: 'start_event_date')
  final String? startEventDate;

  @JsonKey(name: 'end_event_date')
  final String? endEventDate;

  @JsonKey(name: 'event_time')
  final String? eventTime;

  @JsonKey(name: 'note')
  final String? note;

  @JsonKey(includeToJson: false, includeFromJson: false)
  final File? imageFile;

  final LocationInfo location;

  const AddEventParams({
    this.eventType,
    this.name,
    this.description,
    required this.contact,
    this.bookingMethod,
    this.price,
    this.organization,
    this.startTime,
    this.endTime,
    this.startDate,
    this.endDate,
    this.startEventDate,
    this.endEventDate,
    this.eventTime,
    this.note,
    required this.location,
    this.imageFile,
  });

  factory AddEventParams.initial() => AddEventParams(
    eventType: null,
    name: null,
    description: null,
    contact: const ContactInfo(),
    bookingMethod: null,
    price: null,
    organization: null,
    startTime: null,
    endTime: null,
    startDate: null,
    endDate: null,
    startEventDate: null,
    endEventDate: null,
    eventTime: null,
    note: null,
    location: const LocationInfo(),
    imageFile: null,
  );

  AddEventParams copyWith({
    String? eventType,
    String? name,
    String? description,
    ContactInfo? contact,
    String? bookingMethod,
    String? price,
    String? organization,
    String? startTime,
    String? endTime,
    String? startDate,
    String? endDate,
    String? startEventDate,
    String? endEventDate,
    String? eventTime,
    String? note,
    LocationInfo? location,
    File? imageFile,
  }) {
    return AddEventParams(
      eventType: eventType ?? this.eventType,
      name: name ?? this.name,
      description: description ?? this.description,
      contact: contact ?? this.contact,
      bookingMethod: bookingMethod ?? this.bookingMethod,
      price: price ?? this.price,
      organization: organization ?? this.organization,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      startEventDate: startEventDate ?? this.startEventDate,
      endEventDate: endEventDate ?? this.endEventDate,
      eventTime: eventTime ?? this.eventTime,
      note: note ?? this.note,
      location: location ?? this.location,
      imageFile: imageFile ?? this.imageFile,
    );
  }

  factory AddEventParams.fromJson(Map<String, dynamic> json) => _$AddEventParamsFromJson(json);

  Map<String, dynamic> toJson() {
    final map = {
      'event_type': eventType,
      'name': name,
      'description': description,
      'booking_method': bookingMethod,
      'price': price,
      'organization': organization,
      'start_time': startTime,
      'end_time': endTime,
      'start_date': startDate,
      'end_date': endDate,
      'start_event_date': startEventDate,
      'end_event_date': endEventDate,
      'event_time': eventTime,
      'note': note,
      'phone': contact.phone,
      'whatsapp': contact.whatsapp,
      'instagram': contact.instagram,
      'facebook': contact.facebook,
      'latitude': location.lat,
      'longitude': location.lng,
    };
    return map;
  }
}
