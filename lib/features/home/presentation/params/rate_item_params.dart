import 'package:json_annotation/json_annotation.dart';
part 'rate_item_params.g.dart';

@JsonSerializable()
class RateItemParams {
  final int rating;

  RateItemParams({required this.rating});

  factory RateItemParams.fromJson(Map<String, dynamic> json) => _$RateItemParamsFromJson(json);
  Map<String, dynamic> toJson() => _$RateItemParamsToJson(this);
}
