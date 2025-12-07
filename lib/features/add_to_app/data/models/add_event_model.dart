import 'package:json_annotation/json_annotation.dart';

part 'add_event_model.g.dart';

@JsonSerializable()
class AddEventModel {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final num price;
  final String description;
  final double longitude;
  final double latitude;
  final dynamic phone;
  final dynamic whatsapp;
  @JsonKey(name: 'event_type')
  final String eventType;
  final String instagram;
  final String facebook;
  @JsonKey(name: 'booking_method')
  final String bookingMethod;
  final String organization;
  @JsonKey(name: 'start_time')
  final String startTime;
  @JsonKey(name: 'end_time')
  final String endTime;
  @JsonKey(name: 'start_date')
  final String startDate;
  @JsonKey(name: 'end_date')
  final String endDate;
  @JsonKey(name: 'start_event_date')
  final String startEventDate;
  @JsonKey(name: 'end_event_date')
  final String endEventDate;
  @JsonKey(name: 'event_time')
  final String eventTime;
  final String note;

  AddEventModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.longitude,
    required this.latitude,
    required this.phone,
    required this.whatsapp,
    required this.eventType,
    required this.instagram,
    required this.facebook,
    required this.bookingMethod,
    required this.organization,
    required this.startTime,
    required this.endTime,
    required this.startDate,
    required this.endDate,
    required this.startEventDate,
    required this.endEventDate,
    required this.eventTime,
    required this.note,
  });

  factory AddEventModel.fromJson(Map<String, dynamic> json) => _$AddEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddEventModelToJson(this);
}
