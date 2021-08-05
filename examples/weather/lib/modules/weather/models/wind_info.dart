import 'package:json_annotation/json_annotation.dart';

part 'wind_info.g.dart';

/// Информация о ветре

@JsonSerializable()
class WindInfo {
  @JsonKey(defaultValue: 0)
  final double speed;
  @JsonKey(defaultValue: 0)
  final double deg;
  @JsonKey(defaultValue: 0)
  final double gust;

  WindInfo({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory WindInfo.fromJson(Map<String, dynamic> json) =>
      _$WindInfoFromJson(json);
  Map<String, dynamic> toJson() => _$WindInfoToJson(this);

  @override
  String toString() => 'WindInfo(speed: $speed, deg: $deg, gust: $gust)';
}
