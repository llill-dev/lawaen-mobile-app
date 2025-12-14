import 'package:json_annotation/json_annotation.dart';
part 'profile_page_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProfilePageModel {
  final String name;
  final String image;
  final List<Content> content;

  const ProfilePageModel({required this.name, required this.image, required this.content});

  factory ProfilePageModel.fromJson(Map<String, dynamic> json) => _$ProfilePageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfilePageModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Content {
  final String type;
  final String value;

  const Content({required this.type, required this.value});

  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}
