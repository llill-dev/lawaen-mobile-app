import 'package:json_annotation/json_annotation.dart';
part 'profile_pages_model.g.dart';

@JsonSerializable()
class ProfilePagesModel {
  final String id;
  final String name;
  final String image;

  const ProfilePagesModel({required this.id, required this.name, required this.image});

  factory ProfilePagesModel.fromJson(Map<String, dynamic> json) => _$ProfilePagesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfilePagesModelToJson(this);
}
