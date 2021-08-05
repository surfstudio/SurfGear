// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) {
  return WeatherModel(
    weather: (json['weather'] as List<dynamic>)
        .map((e) => WeatherInfo.fromJson(e as Map<String, dynamic>))
        .toList(),
    main: MainInfo.fromJson(json['main'] as Map<String, dynamic>),
    wind: WindInfo.fromJson(json['wind'] as Map<String, dynamic>),
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'weather': instance.weather.map((e) => e.toJson()).toList(),
      'main': instance.main.toJson(),
      'wind': instance.wind.toJson(),
      'name': instance.name,
    };
