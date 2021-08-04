import 'package:json_annotation/json_annotation.dart';

part 'main_info.g.dart';

/// Главные числовые параметры погоды

@JsonSerializable(fieldRename: FieldRename.snake)
class MainInfo {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;

  MainInfo({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  factory MainInfo.fromJson(Map<String, dynamic> json) =>
      _$MainInfoFromJson(json);
  Map<String, dynamic> toJson() => _$MainInfoToJson(this);

  @override
  String toString() {
    return 'MainInfo(temp: $temp, feelsLike: $feelsLike, tempMin: $tempMin, tempMax: $tempMax, pressure: $pressure, humidity: $humidity)';
  }
}
