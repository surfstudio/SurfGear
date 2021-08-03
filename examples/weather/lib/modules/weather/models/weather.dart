import 'package:json_annotation/json_annotation.dart';

import 'package:weather/modules/weather/models/main_info.dart';
import 'package:weather/modules/weather/models/weather_info.dart';
import 'package:weather/modules/weather/models/wind_info.dart';

part 'weather.g.dart';

@JsonSerializable(explicitToJson: true)
class Weather {
  final List<WeatherInfo> weather;
  final MainInfo main;
  final WindInfo wind;
  final String name;

  Weather({
    required this.weather,
    required this.main,
    required this.wind,
    required this.name,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  @override
  String toString() {
    return 'Weather (weather: $weather, main: $main, wind: $wind, name: $name)';
  }
}
