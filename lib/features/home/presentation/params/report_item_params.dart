import 'package:json_annotation/json_annotation.dart';
part 'report_item_params.g.dart';

@JsonSerializable()
class ReportItemParams {
  final String message;

  ReportItemParams({required this.message});

  factory ReportItemParams.fromJson(Map<String, dynamic> json) => _$ReportItemParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ReportItemParamsToJson(this);
}
