import 'package:json_annotation/json_annotation.dart';
part 'contact_model.g.dart';

@JsonSerializable()
class ContactModel {
  final String url;
  final String image;

  ContactModel({required this.url, required this.image});

  factory ContactModel.fromJson(Map<String, dynamic> json) => _$ContactModelFromJson(json);
  Map<String, dynamic> toJson() => _$ContactModelToJson(this);
}
