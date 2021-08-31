// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_anime_list_element.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RawAnimeListElement _$RawAnimeListElementFromJson(Map<String, dynamic> json) {
  return RawAnimeListElement(
    end_date: json['end_date'] as String,
    episodes: json['episodes'] as int,
    image_url: json['image_url'] as String,
    mal_id: json['mal_id'] as int,
    members: json['members'] as int,
    rank: json['rank'] as int,
    score: (json['score'] as num).toDouble(),
    start_date: json['start_date'] as String,
    title: json['title'] as String,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$RawAnimeListElementToJson(
        RawAnimeListElement instance) =>
    <String, dynamic>{
      'end_date': instance.end_date,
      'episodes': instance.episodes,
      'image_url': instance.image_url,
      'mal_id': instance.mal_id,
      'members': instance.members,
      'rank': instance.rank,
      'score': instance.score,
      'start_date': instance.start_date,
      'title': instance.title,
      'type': instance.type,
    };
