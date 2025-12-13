import 'package:json_annotation/json_annotation.dart';

part 'contact_us_model.g.dart';

@JsonSerializable()
class ContactUsModel {
  final bool? success;

  @JsonKey(fromJson: _messageFromJson)
  final String? message;

  const ContactUsModel({this.success, this.message});

  factory ContactUsModel.fromJson(Map<String, dynamic> json) => _$ContactUsModelFromJson(json);
}

String? _messageFromJson(dynamic value) {
  if (value == null) return null;
  if (value is String) return value;
  return value.toString();
}
