import 'package:json_annotation/json_annotation.dart';

part 'weather_info.g.dart';

/// Описание погоды.
/// Основное значение main (напр. Clouds) и descripion (напр. Scattered clouds)

@JsonSerializable()
class WeatherInfo {
  final int id;
  final String main;
  final String description;
  final String icon;

  WeatherInfo({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) =>
      _$WeatherInfoFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherInfoToJson(this);

  @override
  String toString() {
    return 'WeatherInfo(id: $id, main: $main, description: $description, icon: $icon)';
  }
}
