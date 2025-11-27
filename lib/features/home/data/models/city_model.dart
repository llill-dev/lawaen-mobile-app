import 'package:json_annotation/json_annotation.dart';

part 'city_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CityModel {
  //final String id;
  final String name;
  final String image;
  final double radius;
  @JsonKey(name: "center")
  final LocationModel location;

  CityModel({required this.name, required this.image, required this.radius, required this.location});

  factory CityModel.fromJson(Map<String, dynamic> json) => _$CityModelFromJson(json);

  Map<String, dynamic> toJson() => _$CityModelToJson(this);
}

@JsonSerializable()
class LocationModel {
  final double latitude;
  final double longitude;

  LocationModel({required this.latitude, required this.longitude});

  factory LocationModel.fromJson(Map<String, dynamic> json) => _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
