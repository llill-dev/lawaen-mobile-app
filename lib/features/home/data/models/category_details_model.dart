import 'package:json_annotation/json_annotation.dart';
part 'category_details_model.g.dart';

@JsonSerializable()
class CategoryDetailsModel {
  final String id;
  final String? name;
  final String image;
  final String? address;
  final String? main;

  CategoryDetailsModel({
    required this.id,
    required this.name,
    required this.image,
    required this.address,
    required this.main,
  });

  factory CategoryDetailsModel.fromJson(Map<String, dynamic> json) => _$CategoryDetailsModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryDetailsModelToJson(this);
}
