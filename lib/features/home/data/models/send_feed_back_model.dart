import 'package:json_annotation/json_annotation.dart';

part 'send_feed_back_model.g.dart';

@JsonSerializable()
class SendFeedBackModel {
  final bool created;

  SendFeedBackModel({required this.created});

  factory SendFeedBackModel.fromJson(Map<String, dynamic> json) => _$SendFeedBackModelFromJson(json);
  Map<String, dynamic> toJson() => _$SendFeedBackModelToJson(this);
}
