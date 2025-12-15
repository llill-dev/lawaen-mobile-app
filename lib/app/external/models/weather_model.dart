import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherModel {
  @JsonKey(name: "current_weather")
  final CurrentWeatherModel currentWeather;

  WeatherModel({required this.currentWeather});

  factory WeatherModel.fromJson(Map<String, dynamic> json) => _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
}

@JsonSerializable()
class CurrentWeatherModel {
  final double temperature;
  final int weathercode;

  CurrentWeatherModel({required this.temperature, required this.weathercode});

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) => _$CurrentWeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentWeatherModelToJson(this);
}
