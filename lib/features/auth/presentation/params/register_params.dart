import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:lawaen/app/core/models/mobile_info_model.dart';
part 'register_params.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RegisterParams {
  final String name;
  final String? email;
  final String password;
  final String? phone;
  final MobileInfo device;

  @JsonKey(includeToJson: false, includeFromJson: false)
  final File? image;

  RegisterParams({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.device,
    this.image,
  });

  Map<String, dynamic> toJson() => _$RegisterParamsToJson(this);
}
