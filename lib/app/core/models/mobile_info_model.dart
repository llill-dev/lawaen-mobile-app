import 'package:json_annotation/json_annotation.dart';

part 'mobile_info_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class MobileInfo {
  final String brand;
  final String modelName;
  final bool isDevice;
  final String buildId;

  factory MobileInfo.fromJson(Map<String, dynamic> json) => _$MobileInfoFromJson(json);

  Map<String, dynamic> toJson() => _$MobileInfoToJson(this);

  MobileInfo({required this.brand, required this.modelName, required this.isDevice, required this.buildId});
}
