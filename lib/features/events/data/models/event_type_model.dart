import 'package:json_annotation/json_annotation.dart';

part 'event_type_model.g.dart';

@JsonSerializable()
class EventTypeModel {
  final String id;
  final String name;
  final String image;

  EventTypeModel({required this.id, required this.name, required this.image});

  factory EventTypeModel.fromJson(Map<String, dynamic> json) => _$EventTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventTypeModelToJson(this);
}
