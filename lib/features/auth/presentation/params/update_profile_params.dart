import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'update_profile_params.g.dart';

@JsonSerializable()
class UpdateProfileParams {
  final String? name;
  @JsonKey(name: "phone")
  final String? phoneNumber;
  final String? gender;
  @JsonKey(name: "birthday")
  final String? birthDate;
  @JsonKey(includeToJson: false, includeFromJson: false)
  final File? profileImage;

  final String? email;

  UpdateProfileParams({this.name, this.phoneNumber, this.gender, this.birthDate, this.profileImage, this.email});

  Map<String, dynamic> toJson() => _$UpdateProfileParamsToJson(this);
}
