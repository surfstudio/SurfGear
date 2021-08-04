import 'package:json_annotation/json_annotation.dart';

import 'package:weather/modules/weather/models/main_info.dart';
import 'package:weather/modules/weather/models/weather_info.dart';
import 'package:weather/modules/weather/models/wind_info.dart';

part 'weather_model.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherModel {
  final List<WeatherInfo> weather;
  final MainInfo main;
  final WindInfo wind;
  final String name;

  WeatherModel({
    required this.weather,
    required this.main,
    required this.wind,
    required this.name,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

  @override
  String toString() {
    return 'WeatherModel(weather: $weather, main: $main, wind: $wind, name: $name)';
  }
}
