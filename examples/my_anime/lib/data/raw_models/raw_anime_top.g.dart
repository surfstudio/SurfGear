// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_anime_top.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RawAnimeTop _$RawAnimeTopFromJson(Map<String, dynamic> json) {
  return RawAnimeTop(
    top: (json['top'] as List<dynamic>)
        .map((e) => RawAnimeListElement.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$RawAnimeTopToJson(RawAnimeTop instance) =>
    <String, dynamic>{
      'top': instance.top,
    };
