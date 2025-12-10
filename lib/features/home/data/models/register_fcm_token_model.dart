import 'package:json_annotation/json_annotation.dart';
part 'register_fcm_token_model.g.dart';

@JsonSerializable()
class RegisterFcmTokenModel {
  final String? message;
  final bool? success;

  RegisterFcmTokenModel({this.message, this.success});

  factory RegisterFcmTokenModel.fromJson(Map<String, dynamic> json) => _$RegisterFcmTokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterFcmTokenModelToJson(this);
}
