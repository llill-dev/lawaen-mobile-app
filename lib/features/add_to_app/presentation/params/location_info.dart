import 'package:json_annotation/json_annotation.dart';

part 'location_info.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: true)
class LocationInfo {
  @JsonKey(name: 'lat')
  final double? lat;

  @JsonKey(name: 'lng')
  final double? lng;

  const LocationInfo({
    this.lat,
    this.lng,
  });

  LocationInfo copyWith({
    double? lat,
    double? lng,
  }) {
    return LocationInfo(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  factory LocationInfo.fromJson(Map<String, dynamic> json) => _$LocationInfoFromJson(json);

  Map<String, dynamic> toJson() => _$LocationInfoToJson(this);
}
