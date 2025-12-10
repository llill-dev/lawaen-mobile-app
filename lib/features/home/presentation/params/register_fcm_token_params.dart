import 'package:json_annotation/json_annotation.dart';

part 'register_fcm_token_params.g.dart';

@JsonSerializable()
class RegisterFcmTokenParams {
  final String fcmToken;
  final String longitude;
  final String latitude;
  @JsonKey(name: "city_id")
  final String cityId;

  RegisterFcmTokenParams({
    required this.fcmToken,
    required this.longitude,
    required this.latitude,
    required this.cityId,
  });

  Map<String, dynamic> toJson() => _$RegisterFcmTokenParamsToJson(this);
}
