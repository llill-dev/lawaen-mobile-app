import 'dart:io';
import 'package:json_annotation/json_annotation.dart';
import 'package:lawaen/features/add_to_app/presentation/params/accept_options.dart';
import 'package:lawaen/features/add_to_app/presentation/params/contact_info.dart';
import 'package:lawaen/features/add_to_app/presentation/params/location_info.dart';

part 'add_missing_place_params.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class AddMissingPlaceParams {
  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'mainCategory')
  final String? mainCategory;

  @JsonKey(name: 'subCategory')
  final String? subCategory;

  @JsonKey(name: 'message')
  final String? description;

  final ContactInfo contact;

  @JsonKey(name: 'opentime')
  final String? openTime;

  @JsonKey(name: 'closetime')
  final String? closeTime;

  final LocationInfo location;

  final AcceptOptions acceptOptions;

  @JsonKey(name: 'recaptcha')
  final bool recaptcha;

  @JsonKey(includeToJson: false, includeFromJson: false)
  final File? imageFile;

  const AddMissingPlaceParams({
    this.name,
    this.mainCategory,
    this.subCategory,
    this.description,
    required this.contact,
    this.openTime,
    this.closeTime,
    required this.location,
    required this.acceptOptions,
    required this.recaptcha,
    this.imageFile,
  });

  factory AddMissingPlaceParams.initial() => AddMissingPlaceParams(
    name: null,
    mainCategory: null,
    subCategory: null,
    description: null,
    contact: const ContactInfo(),
    openTime: null,
    closeTime: null,
    location: const LocationInfo(),
    acceptOptions: const AcceptOptions(),
    recaptcha: false,
    imageFile: null,
  );

  AddMissingPlaceParams copyWith({
    String? name,
    String? mainCategory,
    String? subCategory,
    String? description,
    ContactInfo? contact,
    String? openTime,
    String? closeTime,
    LocationInfo? location,
    AcceptOptions? acceptOptions,
    bool? recaptcha,
    File? imageFile,
  }) {
    return AddMissingPlaceParams(
      name: name ?? this.name,
      mainCategory: mainCategory ?? this.mainCategory,
      subCategory: subCategory ?? this.subCategory,
      description: description ?? this.description,
      contact: contact ?? this.contact,
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
      location: location ?? this.location,
      acceptOptions: acceptOptions ?? this.acceptOptions,
      recaptcha: recaptcha ?? this.recaptcha,
      imageFile: imageFile ?? this.imageFile,
    );
  }

  factory AddMissingPlaceParams.fromJson(Map<String, dynamic> json) => _$AddMissingPlaceParamsFromJson(json);

  Map<String, dynamic> toJson() {
    final map = {
      'name': name,
      'mainCategory': mainCategory,
      'subCategory': subCategory,
      'message': description,
      'opentime': openTime,
      'closetime': closeTime,
      'recaptcha': recaptcha,
    };

    map['phone'] = contact.phone;
    map['whatsapp'] = contact.whatsapp;
    map['faceBook'] = contact.facebook;
    map['insta'] = contact.instagram;

    map['latitude'] = location.lat;
    map['longitude'] = location.lng;

    map['acceptOne'] = acceptOptions.acceptOne;
    map['acceptTwo'] = acceptOptions.acceptTwo;
    map['acceptThree'] = acceptOptions.acceptThree;

    return map;
  }
}
