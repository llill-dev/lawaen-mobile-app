import 'package:json_annotation/json_annotation.dart';

part 'add_offer_model.g.dart';

@JsonSerializable()
class AddOfferModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final dynamic phone;
  final String? message;
  final dynamic whatsapp;
  final String? image;
  final bool? acceptOne;
  final bool? acceptTwo;
  final bool? acceptThree;
  final bool? recaptcha;
  @JsonKey(name: 'is_show')
  final bool? isShow;

  AddOfferModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.message,
    required this.whatsapp,
    required this.image,
    required this.acceptOne,
    required this.acceptTwo,
    required this.acceptThree,
    required this.recaptcha,
    required this.isShow,
  });

  factory AddOfferModel.fromJson(Map<String, dynamic> json) => _$AddOfferModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddOfferModelToJson(this);
}
