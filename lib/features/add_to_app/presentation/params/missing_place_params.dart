import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:lawaen/features/add_to_app/presentation/params/accept_options.dart';
import 'package:lawaen/features/add_to_app/presentation/params/contact_info.dart';
import 'package:lawaen/features/add_to_app/presentation/params/location_info.dart';

part 'missing_place_params.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class MissingPlaceParams {
  @JsonKey(name: 'mainCategory')
  final String? mainCategory;

  @JsonKey(name: 'subCategory')
  final String? subCategory;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'description')
  final String? description;

  /// Contact (flattened in [toJson]).
  final ContactInfo contact;

  @JsonKey(name: 'startTime')
  final String? startTime;

  @JsonKey(name: 'endTime')
  final String? endTime;

  /// Image is handled separately (multipart).
  @JsonKey(includeToJson: false, includeFromJson: false)
  final File? imageFile;

  /// Location (flattened in [toJson]).
  final LocationInfo location;

  final AcceptOptions acceptOptions;

  const MissingPlaceParams({
    this.mainCategory,
    this.subCategory,
    this.name,
    this.description,
    required this.contact,
    this.startTime,
    this.endTime,
    this.imageFile,
    required this.acceptOptions,
    required this.location,
  });

  factory MissingPlaceParams.initial() => MissingPlaceParams(
    mainCategory: null,
    subCategory: null,
    name: null,
    description: null,
    contact: const ContactInfo(),
    startTime: null,
    endTime: null,
    imageFile: null,
    location: const LocationInfo(),
    acceptOptions: const AcceptOptions(),
  );

  MissingPlaceParams copyWith({
    String? mainCategory,
    String? subCategory,
    String? name,
    String? description,
    ContactInfo? contact,
    String? startTime,
    String? endTime,
    File? imageFile,
    LocationInfo? location,
    AcceptOptions? acceptOptions,
  }) {
    return MissingPlaceParams(
      mainCategory: mainCategory ?? this.mainCategory,
      subCategory: subCategory ?? this.subCategory,
      name: name ?? this.name,
      description: description ?? this.description,
      contact: contact ?? this.contact,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      imageFile: imageFile ?? this.imageFile,
      location: location ?? this.location,
      acceptOptions: acceptOptions ?? this.acceptOptions,
    );
  }

  factory MissingPlaceParams.fromJson(Map<String, dynamic> json) => _$MissingPlaceParamsFromJson(json);

  /// Flatten contact and location into a single JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> base = {
      'mainCategory': mainCategory,
      'subCategory': subCategory,
      'name': name,
      'description': description,
      'startTime': startTime,
      'endTime': endTime,
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
