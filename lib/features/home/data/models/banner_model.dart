import 'package:json_annotation/json_annotation.dart';

part 'banner_model.g.dart';

@JsonSerializable()
class BannerModel {
  final String? id;
  final String? image;
  @JsonKey(name: "in_home")
  final bool? inhome;
  @JsonKey(name: "go_to")
  final String? goTo;

  BannerModel({this.id, this.image, this.inhome, this.goTo});

  factory BannerModel.fromJson(Map<String, dynamic> json) => _$BannerModelFromJson(json);

  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}
