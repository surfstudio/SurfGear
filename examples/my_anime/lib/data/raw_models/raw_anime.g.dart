// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_anime.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RawAnime _$RawAnimeFromJson(Map<String, dynamic> json) {
  return RawAnime(
    aired: RawAired.fromJson(json['aired'] as Map<String, dynamic>),
    airing: json['airing'] as bool,
    background: json['background'] as String,
    broadcast: json['broadcast'] as String,
    duration: json['duration'] as String,
    ending_themes: (json['ending_themes'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    episodes: json['episodes'] as int,
    favorites: json['favorites'] as int,
    genres: (json['genres'] as List<dynamic>)
        .map((e) => RawGenre.fromJson(e as Map<String, dynamic>))
        .toList(),
    image_url: json['image_url'] as String,
    mal_id: json['mal_id'] as int,
    members: json['members'] as int,
    opening_themes: (json['opening_themes'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    popularity: json['popularity'] as int,
    premiered: json['premiered'] as String,
    rank: json['rank'] as int,
    rating: json['rating'] as String,
    score: (json['score'] as num).toDouble(),
    scored_by: json['scored_by'] as int,
    status: json['status'] as String,
    synopsis: json['synopsis'] as String,
    title: json['title'] as String,
    title_english: json['title_english'] as String,
    title_japanese: json['title_japanese'] as String,
    trailer_url: json['trailer_url'] as String,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$RawAnimeToJson(RawAnime instance) => <String, dynamic>{
      'aired': instance.aired,
      'airing': instance.airing,
      'background': instance.background,
      'broadcast': instance.broadcast,
      'duration': instance.duration,
      'ending_themes': instance.ending_themes,
      'episodes': instance.episodes,
      'favorites': instance.favorites,
      'genres': instance.genres,
      'image_url': instance.image_url,
      'mal_id': instance.mal_id,
      'members': instance.members,
      'opening_themes': instance.opening_themes,
      'popularity': instance.popularity,
      'premiered': instance.premiered,
      'rank': instance.rank,
      'rating': instance.rating,
      'score': instance.score,
      'scored_by': instance.scored_by,
      'status': instance.status,
      'synopsis': instance.synopsis,
      'title': instance.title,
      'title_english': instance.title_english,
      'title_japanese': instance.title_japanese,
      'trailer_url': instance.trailer_url,
      'type': instance.type,
    };

RawAired _$RawAiredFromJson(Map<String, dynamic> json) {
  return RawAired(
    from: json['from'] as String,
    string: json['string'] as String,
    to: json['to'] as String,
  );
}

Map<String, dynamic> _$RawAiredToJson(RawAired instance) => <String, dynamic>{
      'from': instance.from,
      'string': instance.string,
      'to': instance.to,
    };

RawGenre _$RawGenreFromJson(Map<String, dynamic> json) {
  return RawGenre(
    mal_id: json['mal_id'] as int,
    name: json['name'] as String,
    type: json['type'] as String,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$RawGenreToJson(RawGenre instance) => <String, dynamic>{
      'mal_id': instance.mal_id,
      'name': instance.name,
      'type': instance.type,
      'url': instance.url,
    };
