import 'package:json_annotation/json_annotation.dart';

part 'offer_model.g.dart';

@JsonSerializable()
class OfferModel {
  final String id;
  final String name;
  final String image;
  final String description;
  final String? facebook;
  final String? phone;

  OfferModel({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    this.facebook,
    this.phone,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) => _$OfferModelFromJson(json);

  Map<String, dynamic> toJson() => _$OfferModelToJson(this);
}
