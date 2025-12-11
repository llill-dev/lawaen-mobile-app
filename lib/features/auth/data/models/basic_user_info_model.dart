import 'package:json_annotation/json_annotation.dart';

part 'basic_user_info_model.g.dart';

@JsonSerializable()
class BasicUserInfo {
  final String name;
  final String? emailOrPhone;
  final String? image;
  final String? phone;

  BasicUserInfo({required this.name, this.emailOrPhone, this.image, this.phone});

  factory BasicUserInfo.fromJson(Map<String, dynamic> json) => _$BasicUserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$BasicUserInfoToJson(this);
}
