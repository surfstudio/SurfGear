// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wind_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WindInfo _$WindInfoFromJson(Map<String, dynamic> json) {
  return WindInfo(
    speed: (json['speed'] as num?)?.toDouble() ?? 0,
    deg: (json['deg'] as num?)?.toDouble() ?? 0,
    gust: (json['gust'] as num?)?.toDouble() ?? 0,
  );
}

Map<String, dynamic> _$WindInfoToJson(WindInfo instance) => <String, dynamic>{
      'speed': instance.speed,
      'deg': instance.deg,
      'gust': instance.gust,
    };
