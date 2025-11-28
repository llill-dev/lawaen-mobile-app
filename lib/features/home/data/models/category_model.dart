import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CategoryModel {
  final String id;
  final String name;
  final String image;
  final String? description;

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

  final String? image;

  @JsonKey(defaultValue: "")
  final String name;

  final String? description;

  @JsonKey(fromJson: _countsFromJson, toJson: _countsToJson)
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
  static Map<String, int> _countsFromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return json.map((key, value) {
        final parsedValue = int.tryParse(value.toString()) ?? 0;
        return MapEntry(key, parsedValue);
      });
    }

    return {};
  }

  static Map<String, dynamic> _countsToJson(Map<String, int> counts) => counts;
}
