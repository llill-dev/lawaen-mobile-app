import 'package:json_annotation/json_annotation.dart';

part 'mune_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MuneModel {
  @JsonKey(defaultValue: [])
  final List<MenuCategory> categories;

  MuneModel({required this.categories});

  factory MuneModel.fromJson(Map<String, dynamic> json) => _$MuneModelFromJson(json);

  Map<String, dynamic> toJson() => _$MuneModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MenuCategory {
  final String? id;
  final String? title;
  @JsonKey(defaultValue: [])
  final List<MenuItem> items;

  MenuCategory({this.id, this.title, required this.items});

  factory MenuCategory.fromJson(Map<String, dynamic> json) => _$MenuCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$MenuCategoryToJson(this);
}

@JsonSerializable()
class MenuItem {
  final String? id;
  final String? title;
  final num? price;
  final String? description;
  final String? image;

  MenuItem({this.id, this.title, this.price, this.description, this.image});

  factory MenuItem.fromJson(Map<String, dynamic> json) => _$MenuItemFromJson(json);

  Map<String, dynamic> toJson() => _$MenuItemToJson(this);
}
