import 'package:json_annotation/json_annotation.dart';

part 'weather_api_response_model.g.dart';

@JsonSerializable()
class WeatherApiResponseModel {
  @JsonKey(name: 'current_weather')
  final CurrentWeatherApiModel? currentWeather;

  WeatherApiResponseModel({this.currentWeather});

  factory WeatherApiResponseModel.fromJson(Map<String, dynamic> json) => _$WeatherApiResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherApiResponseModelToJson(this);
}

@JsonSerializable()
class CurrentWeatherApiModel {
  final double? temperature;
  final int? weathercode;

  CurrentWeatherApiModel({this.temperature, this.weathercode});

  factory CurrentWeatherApiModel.fromJson(Map<String, dynamic> json) => _$CurrentWeatherApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentWeatherApiModelToJson(this);
}
