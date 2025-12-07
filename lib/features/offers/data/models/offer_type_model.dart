import 'package:json_annotation/json_annotation.dart';

part 'offer_type_model.g.dart';

@JsonSerializable()
class OfferTypeModel {
  final String id;
  final String name;

  OfferTypeModel({
    required this.id,
    required this.name,
  });

  factory OfferTypeModel.fromJson(Map<String, dynamic> json) => _$OfferTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$OfferTypeModelToJson(this);
}
