import 'package:json_annotation/json_annotation.dart';

part 'message_api_reponse.g.dart';

@JsonSerializable(explicitToJson: true)
class MessageApiResponse {
  final bool? status;
  final String? message;
  final List<MessageModel>? data;
  final int? page;
  final int? total;
  final int? limit;
  final int? totalPage;

  MessageApiResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.page,
    required this.total,
    required this.limit,
    required this.totalPage,
  });

  factory MessageApiResponse.fromJson(Map<String, dynamic> json) => _$MessageApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MessageApiResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MessageModel {
  @JsonKey(name: "user_id")
  final String userId;
  @JsonKey(name: "model_id")
  final String modelId;
  final String second;
  final String message;

  MessageModel({required this.userId, required this.modelId, required this.second, required this.message});

  factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
