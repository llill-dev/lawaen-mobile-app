import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'claim_item.params.g.dart';

@JsonSerializable()
class ClaimItemParams {
  final String? note;
  final String? phone;

  @JsonKey(includeToJson: false, includeFromJson: false)
  final List<File>? images;

  ClaimItemParams({this.note, this.phone, this.images});

  factory ClaimItemParams.fromJson(Map<String, dynamic> json) => _$ClaimItemParamsFromJson(json);
  Map<String, dynamic> toJson() => _$ClaimItemParamsToJson(this);
}
