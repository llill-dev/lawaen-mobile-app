import 'package:json_annotation/json_annotation.dart';

part 'event_model.g.dart';

@JsonSerializable()
class EventModel {
  final String? id;
  final String? image;
  final String? name;
  final num? price;
  @JsonKey(name: 'event_type')
  final String? eventType;
  final String? description;
  final double? latitude;
  final double? longitude;
  final String? organization;
  final String? phone;
  @JsonKey(name: 'start_time')
  final String? startTime;
  @JsonKey(name: 'end_time')
  final String? endTime;
  @JsonKey(name: 'start_date')
  final String? startDate;
  @JsonKey(name: 'end_date')
  final String? endDate;
  final String? note;

  EventModel({
    this.id,
    this.image,
    this.name,
    this.price,
    this.eventType,
    this.description,
    this.latitude,
    this.longitude,
    this.organization,
    this.phone,
    this.startTime,
    this.endTime,
    this.startDate,
    this.endDate,
    this.note,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => _$EventModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventModelToJson(this);
}
