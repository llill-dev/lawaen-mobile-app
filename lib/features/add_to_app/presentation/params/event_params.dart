import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:lawaen/features/add_to_app/presentation/params/accept_options.dart';
import 'package:lawaen/features/add_to_app/presentation/params/contact_info.dart';
import 'package:lawaen/features/add_to_app/presentation/params/location_info.dart';

part 'event_params.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class EventParams {
  @JsonKey(name: 'event_type')
  final String? eventType;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'description')
  final String? description;

  /// Contact (flattened in [toJson]).
  final ContactInfo contact;

  @JsonKey(name: 'booking_method')
  final String? bookingMethod;

  @JsonKey(name: 'price')
  final String? price;

  @JsonKey(name: 'booking_fee')
  final String? bookingFee;

  @JsonKey(name: 'organiser_link')
  final String? organiserLink;

  @JsonKey(name: 'start_time')
  final String? startTime;

  @JsonKey(name: 'end_time')
  final String? endTime;

  @JsonKey(name: 'start_date')
  final String? startDate;

  @JsonKey(name: 'end_date')
  final String? endDate;

  @JsonKey(name: 'event_time')
  final String? eventTime;

  /// Image is handled separately (multipart).
  @JsonKey(includeToJson: false, includeFromJson: false)
  final File? imageFile;

  /// Location (flattened in [toJson]).
  final LocationInfo location;

  final AcceptOptions acceptOptions;

  const EventParams({
    this.eventType,
    this.name,
    this.description,
    required this.contact,
    this.bookingMethod,
    this.price,
    this.bookingFee,
    this.organiserLink,
    this.startTime,
    this.endTime,
    this.startDate,
    this.endDate,
    this.eventTime,
    required this.location,
    required this.acceptOptions,
    this.imageFile,
  });

  factory EventParams.initial() => EventParams(
        eventType: null,
        name: null,
        description: null,
        contact: const ContactInfo(),
        bookingMethod: null,
        price: null,
        bookingFee: null,
        organiserLink: null,
        startTime: null,
        endTime: null,
        startDate: null,
        endDate: null,
        eventTime: null,
        location: const LocationInfo(),
        acceptOptions: const AcceptOptions(),
        imageFile: null,
      );

  EventParams copyWith({
    String? eventType,
    String? name,
    String? description,
    ContactInfo? contact,
    String? bookingMethod,
    String? price,
    String? bookingFee,
    String? organiserLink,
    String? startTime,
    String? endTime,
    String? startDate,
    String? endDate,
    String? eventTime,
    LocationInfo? location,
    AcceptOptions? acceptOptions,
    File? imageFile,
  }) {
    return EventParams(
      eventType: eventType ?? this.eventType,
      name: name ?? this.name,
      description: description ?? this.description,
      contact: contact ?? this.contact,
      bookingMethod: bookingMethod ?? this.bookingMethod,
      price: price ?? this.price,
      bookingFee: bookingFee ?? this.bookingFee,
      organiserLink: organiserLink ?? this.organiserLink,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      eventTime: eventTime ?? this.eventTime,
      location: location ?? this.location,
      acceptOptions: acceptOptions ?? this.acceptOptions,
      imageFile: imageFile ?? this.imageFile,
    );
  }

  factory EventParams.fromJson(Map<String, dynamic> json) => _$EventParamsFromJson(json);

  /// Flatten contact and location into a single JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> base = {
      'event_type': eventType,
      'name': name,
      'description': description,
      'booking_method': bookingMethod,
      'price': price,
      'booking_fee': bookingFee,
      'organiser_link': organiserLink,
      'start_time': startTime,
      'end_time': endTime,
      'start_date': startDate,
      'end_date': endDate,
      'event_time': eventTime,
    };

    final contactJson = contact.toJson();
    base['phone'] = contactJson['phone'];
    base['whatsapp'] = contactJson['whatsapp'];
    base['instagram'] = contactJson['instagram'];
    base['facebook'] = contactJson['facebook'];

    final locationJson = location.toJson();
    base['lat'] = locationJson['lat'];
    base['lng'] = locationJson['lng'];

    final acceptOptionsJson = acceptOptions.toJson();
    base['acceptOne'] = acceptOptionsJson['acceptOne'];
    base['acceptTwo'] = acceptOptionsJson['acceptTwo'];
    base['acceptThree'] = acceptOptionsJson['acceptThree'];

    return base;
  }
}
