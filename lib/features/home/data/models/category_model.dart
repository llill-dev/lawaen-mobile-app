import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CategoryModel {
  final String id;
  final String name;
  final String image;
  final String description;

  @JsonKey(name: 'second_category')
  final List<SecondCategory> secondCategory;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.secondCategory,
  });

  int get totalCategoryCount {
    return secondCategory.fold(0, (sum, item) => sum + item.totalCount);
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

@JsonSerializable()
class SecondCategory {
  final String id;

  @JsonKey(name: 'category_id')
  final String categoryId;

  final String image;
  final String name;
  final String description;
  final Map<String, int> counts;

  SecondCategory({
    required this.id,
    required this.categoryId,
    required this.image,
    required this.name,
    required this.description,
    required this.counts,
  });

  int get totalCount => counts.values.fold(0, (a, b) => a + b);

  factory SecondCategory.fromJson(Map<String, dynamic> json) => _$SecondCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SecondCategoryToJson(this);
}
