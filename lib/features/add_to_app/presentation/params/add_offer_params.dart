import 'dart:io';
import 'package:json_annotation/json_annotation.dart';
import 'package:lawaen/features/add_to_app/presentation/params/contact_info.dart';
import 'package:lawaen/features/add_to_app/presentation/params/accept_options.dart';

part 'add_offer_params.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class AddOfferParams {
  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'message')
  final String? description;

  /// Contact (flattened)
  final ContactInfo contact;

  /// Accept options (flattened)
  final AcceptOptions acceptOptions;

  @JsonKey(name: 'recaptcha')
  final bool recaptcha;

  @JsonKey(includeToJson: false, includeFromJson: false)
  final File? imageFile;

  const AddOfferParams({
    this.name,
    this.description,
    required this.contact,
    required this.acceptOptions,
    required this.recaptcha,
    this.imageFile,
  });

  factory AddOfferParams.initial() => const AddOfferParams(
    name: null,
    description: null,
    contact: ContactInfo(),
    acceptOptions: AcceptOptions(),
    recaptcha: false,
    imageFile: null,
  );

  AddOfferParams copyWith({
    String? name,
    String? description,
    ContactInfo? contact,
    AcceptOptions? acceptOptions,
    bool? recaptcha,
    File? imageFile,
  }) {
    return AddOfferParams(
      name: name ?? this.name,
      description: description ?? this.description,
      contact: contact ?? this.contact,
      acceptOptions: acceptOptions ?? this.acceptOptions,
      recaptcha: recaptcha ?? this.recaptcha,
      imageFile: imageFile ?? this.imageFile,
    );
  }

  factory AddOfferParams.fromJson(Map<String, dynamic> json) => _$AddOfferParamsFromJson(json);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'message': description,
      'phone': contact.phone,
      'whatsapp': contact.whatsapp,
      'acceptOne': acceptOptions.acceptOne,
      'acceptTwo': acceptOptions.acceptTwo,
      'acceptThree': acceptOptions.acceptThree,
      'recaptcha': recaptcha,
    };
  }
}
