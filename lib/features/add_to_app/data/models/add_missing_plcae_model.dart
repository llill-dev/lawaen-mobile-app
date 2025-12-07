import 'package:json_annotation/json_annotation.dart';

part 'add_missing_plcae_model.g.dart';

@JsonSerializable()
class AddMissingPlcaeModel {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String mainCategory;
  final String subCategory;
  final String phone;
  final String message;
  final String whatsapp;
  @JsonKey(name: 'faceBook')
  final String facebook;
  final String insta;
  final String image;
  final String opentime;
  final String closetime;
  final double longitude;
  final double latitude;
  final bool acceptOne;
  final bool acceptTwo;
  final bool acceptThree;
  final bool recaptcha;
  @JsonKey(name: 'is_show')
  final bool isShow;

  AddMissingPlcaeModel({
    required this.id,
    required this.name,
    required this.mainCategory,
    required this.subCategory,
    required this.phone,
    required this.message,
    required this.whatsapp,
    required this.facebook,
    required this.insta,
    required this.image,
    required this.opentime,
    required this.closetime,
    required this.longitude,
    required this.latitude,
    required this.acceptOne,
    required this.acceptTwo,
    required this.acceptThree,
    required this.recaptcha,
    required this.isShow,
  });

  factory AddMissingPlcaeModel.fromJson(Map<String, dynamic> json) => _$AddMissingPlcaeModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddMissingPlcaeModelToJson(this);
}
