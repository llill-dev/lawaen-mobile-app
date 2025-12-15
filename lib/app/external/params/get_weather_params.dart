import 'package:json_annotation/json_annotation.dart';

part 'get_weather_params.g.dart';

@JsonSerializable(includeIfNull: false)
class GetWeatherParams {
  final double latitude;
  final double longitude;

  @JsonKey(name: "current_weather")
  final bool currentWeather;

  @JsonKey(name: "temperature_unit")
  final String temperatureUnit;

  GetWeatherParams({
    required this.latitude,
    required this.longitude,
    this.currentWeather = true,
    this.temperatureUnit = "celsius",
  });

  Map<String, dynamic> toJson() => _$GetWeatherParamsToJson(this);
}
