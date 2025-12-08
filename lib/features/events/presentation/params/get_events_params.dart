import 'package:json_annotation/json_annotation.dart';

part 'get_events_params.g.dart';

@JsonSerializable()
class GetEventsParams {
  final String city;

  GetEventsParams({required this.city});

  Map<String, dynamic> toJson() => _$GetEventsParamsToJson(this);
}
