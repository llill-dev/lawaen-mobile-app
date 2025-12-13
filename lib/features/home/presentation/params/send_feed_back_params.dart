import 'package:json_annotation/json_annotation.dart';
part 'send_feed_back_params.g.dart';

@JsonSerializable()
class SendFeedBackParams {
  final String message;

  SendFeedBackParams({required this.message});

  factory SendFeedBackParams.fromJson(Map<String, dynamic> json) => _$SendFeedBackParamsFromJson(json);
  Map<String, dynamic> toJson() => _$SendFeedBackParamsToJson(this);
}
