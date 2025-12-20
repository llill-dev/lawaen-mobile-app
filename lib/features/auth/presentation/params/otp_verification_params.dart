import 'package:json_annotation/json_annotation.dart';
part 'otp_verification_params.g.dart';

@JsonSerializable(includeIfNull: false)
class OtpVerificationParams {
  final String? email;
  final String? phone;
  final String passcode;

  OtpVerificationParams({this.email, this.phone, required this.passcode});

  Map<String, dynamic> toJson() => _$OtpVerificationParamsToJson(this);
}
