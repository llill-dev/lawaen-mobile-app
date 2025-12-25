// notification_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  @JsonKey(name: 'id')
  final String? id;
  final String? title;
  final String? body;
  @JsonKey(name: 'is_read')
  final bool? isRead;
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  final String? imageUrl;

  final String? screen;
  @JsonKey(name: 'dedupeKey')
  final String? dedupeKey;
  @JsonKey(name: 'user_id')
  final String? userId;
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  NotificationModel({
    this.id,
    this.title,
    this.body,
    this.isRead,
    this.createdAt,
    this.imageUrl,
    this.screen,
    this.dedupeKey,
    this.userId,
    this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
