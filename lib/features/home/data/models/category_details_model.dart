import 'package:json_annotation/json_annotation.dart';
part 'category_details_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CategoryDetailsModel {
  final String id;
  final String? name;
  final String? image;
  final String? address;
  final String? main;
  @JsonKey(name: "main_category_id")
  final String? mainCategoryId;
  final double? travelMinutes;
  final LocationMapModel? location;

  CategoryDetailsModel({
    required this.id,
    required this.name,
    required this.image,
    required this.address,
    required this.main,
    required this.location,
    required this.mainCategoryId,
    this.travelMinutes,
  });

  factory CategoryDetailsModel.fromJson(Map<String, dynamic> json) => _$CategoryDetailsModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryDetailsModelToJson(this);

  CategoryDetailsModel copyWith({double? travelMinutes}) {
    return CategoryDetailsModel(
      id: id,
      name: name,
      image: image,
      address: address,
      main: main,
      location: location,
      mainCategoryId: mainCategoryId,
      travelMinutes: travelMinutes ?? this.travelMinutes,
    );
  }
}

@JsonSerializable(explicitToJson: true)
class LocationMapModel {
  final double? latitude;
  final double? longitude;
  final String? address;

  LocationMapModel({this.address, this.latitude, this.longitude});

  factory LocationMapModel.fromJson(Map<String, dynamic> json) => _$LocationMapModelFromJson(json);
  Map<String, dynamic> toJson() => _$LocationMapModelToJson(this);
}
