import 'package:json_annotation/json_annotation.dart';

part 'contact_us_params.g.dart';

@JsonSerializable()
class ContactUsParams {
  final String type;
  final String message;

  ContactUsParams({required this.type, required this.message});

  factory ContactUsParams.fromJson(Map<String, dynamic> json) => _$ContactUsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ContactUsParamsToJson(this);
}
