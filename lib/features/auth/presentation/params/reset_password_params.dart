import 'package:json_annotation/json_annotation.dart';

part 'reset_password_params.g.dart';

@JsonSerializable(includeIfNull: false)
class ResetPasswordParams {
  final String? email;
  final String? phone;
  final String password;

  ResetPasswordParams({this.email, this.phone, required this.password});

  Map<String, dynamic> toJson() => _$ResetPasswordParamsToJson(this);
}
