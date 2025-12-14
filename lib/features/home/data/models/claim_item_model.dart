import 'package:json_annotation/json_annotation.dart';

part 'claim_item_model.g.dart';

@JsonSerializable()
class ClaimItemModel {
  final bool saved;
  final bool updated;

  ClaimItemModel({required this.saved, required this.updated});

  factory ClaimItemModel.fromJson(Map<String, dynamic> json) => _$ClaimItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$ClaimItemModelToJson(this);
}
