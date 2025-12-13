import 'package:json_annotation/json_annotation.dart';

part 'toggle_model.g.dart';

@JsonSerializable()
class ToggleModel {
  final bool saved;

  ToggleModel({required this.saved});

  factory ToggleModel.fromJson(Map<String, dynamic> json) => _$ToggleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ToggleModelToJson(this);
}
