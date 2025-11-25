import 'package:json_annotation/json_annotation.dart';
import 'package:lawaen/app/core/models/mobile_info_model.dart';
part 'login_params.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LoginParams {
  final String? email;
  final String password;
  final String? phone;
  final MobileInfo device;

  LoginParams({this.phone, this.email, required this.password, required this.device});

  Map<String, dynamic> toJson() => _$LoginParamsToJson(this);
}
