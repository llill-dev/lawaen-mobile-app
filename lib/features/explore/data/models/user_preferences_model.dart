import 'package:json_annotation/json_annotation.dart';

part 'user_preferences_model.g.dart';

@JsonSerializable()
class UserPreferencesModel {
  final String id;
  final String name;

  const UserPreferencesModel({
    required this.id,
    required this.name,
  });

  factory UserPreferencesModel.fromJson(Map<String, dynamic> json) => _$UserPreferencesModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserPreferencesModelToJson(this);
}
