import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:lawaen/features/add_to_app/presentation/params/contact_info.dart';

part 'offer_params.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class OfferParams {
  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'description')
  final String? description;

  /// Contact (flattened in [toJson]).
  final ContactInfo contact;

  /// Image is handled separately (multipart).
  @JsonKey(includeToJson: false, includeFromJson: false)
  final File? imageFile;

  const OfferParams({
    this.name,
    this.description,
    required this.contact,
    this.imageFile,
  });

  factory OfferParams.initial() => OfferParams(
        name: null,
        description: null,
        contact: const ContactInfo(),
        imageFile: null,
      );

  OfferParams copyWith({
    String? name,
    String? description,
    ContactInfo? contact,
    File? imageFile,
  }) {
    return OfferParams(
      name: name ?? this.name,
      description: description ?? this.description,
      contact: contact ?? this.contact,
      imageFile: imageFile ?? this.imageFile,
    );
  }

  factory OfferParams.fromJson(Map<String, dynamic> json) => _$OfferParamsFromJson(json);

  /// Flatten contact into a single JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> base = {
      'name': name,
      'description': description,
    };

    final contactJson = contact.toJson();
    base['phone'] = contactJson['phone'];
    base['whatsapp'] = contactJson['whatsapp'];
    base['instagram'] = contactJson['instagram'];
    base['facebook'] = contactJson['facebook'];

    return base;
  }
}
