import 'package:json_annotation/json_annotation.dart';

part 'map_marker_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MapMarkerModel {
  final String mainCategoryId;
  final String markerIcon;

  MapMarkerModel({required this.mainCategoryId, required this.markerIcon});

  factory MapMarkerModel.fromJson(Map<String, dynamic> json) => _$MapMarkerModelFromJson(json);

  Map<String, dynamic> toJson() => _$MapMarkerModelToJson(this);
}
