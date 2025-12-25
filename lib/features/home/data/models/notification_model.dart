import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  final String? id;
  final String? title;
  final String? body;

  @JsonKey(name: 'is_read')
  final bool? isRead;

  final String? createdAt;

  @JsonKey(name: 'imageUrl')
  final String? imageUrl;

  NotificationModel({this.id, this.title, this.body, this.isRead, this.createdAt, this.imageUrl});

  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
