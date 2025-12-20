import 'package:json_annotation/json_annotation.dart';
part 'forget_password_params.g.dart';

@JsonSerializable(includeIfNull: false)
class ForgetPasswordParams {
  final String? email;
  final String? phone;

  ForgetPasswordParams({this.email, this.phone});

  Map<String, dynamic> toJson() => _$ForgetPasswordParamsToJson(this);
}
