import 'package:json_annotation/json_annotation.dart';

part 'basic_user_info_model.g.dart';

@JsonSerializable()
class BasicUserInfo {
  final String name;
  final String? email;
  final String? image;
  final String? phone;
  final String id;

  BasicUserInfo({required this.name, this.email, this.image, this.phone, required this.id});

  factory BasicUserInfo.fromJson(Map<String, dynamic> json) => _$BasicUserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$BasicUserInfoToJson(this);
}
