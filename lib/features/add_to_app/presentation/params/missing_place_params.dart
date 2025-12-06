import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:lawaen/features/add_to_app/presentation/params/contact_info.dart';
import 'package:lawaen/features/add_to_app/presentation/params/location_info.dart';

part 'missing_place_params.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class MissingPlaceParams {
  @JsonKey(name: 'main_category')
  final String? mainCategory;

  @JsonKey(name: 'sub_category')
  final String? subCategory;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'description')
  final String? description;

  /// Contact (flattened in [toJson]).
  final ContactInfo contact;

  @JsonKey(name: 'start_time')
  final String? startTime;

  @JsonKey(name: 'end_time')
  final String? endTime;

  /// Image is handled separately (multipart).
  @JsonKey(includeToJson: false, includeFromJson: false)
  final File? imageFile;

  /// Location (flattened in [toJson]).
  final LocationInfo location;

  const MissingPlaceParams({
    this.mainCategory,
    this.subCategory,
    this.name,
    this.description,
    required this.contact,
    this.startTime,
    this.endTime,
    this.imageFile,
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
    );
  }

  factory MissingPlaceParams.fromJson(Map<String, dynamic> json) => _$MissingPlaceParamsFromJson(json);

  /// Flatten contact and location into a single JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> base = {
      'main_category': mainCategory,
      'sub_category': subCategory,
      'name': name,
      'description': description,
      'start_time': startTime,
      'end_time': endTime,
    };

    final contactJson = contact.toJson();
    base['phone'] = contactJson['phone'];
    base['whatsapp'] = contactJson['whatsapp'];
    base['instagram'] = contactJson['instagram'];
    base['facebook'] = contactJson['facebook'];

    final locationJson = location.toJson();
    base['lat'] = locationJson['lat'];
    base['lng'] = locationJson['lng'];

    return base;
  }
}
