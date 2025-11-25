import 'package:json_annotation/json_annotation.dart';

part 'change_password_params.g.dart';

@JsonSerializable()
class ChangePasswordParams {
  final String oldPassword;
  final String newPassword;
  final String login;
  ChangePasswordParams({required this.oldPassword, required this.login, required this.newPassword});

  Map<String, dynamic> toJson() => _$ChangePasswordParamsToJson(this);
}
