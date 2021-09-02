import 'package:json_annotation/json_annotation.dart';

part 'raw_anime.g.dart';

@JsonSerializable()
class RawAnime {
  RawAnime({
    this.aired = const RawAired(),
    this.airing = false,
    this.background = '',
    this.broadcast = '',
    this.duration = '',
    this.ending_themes = const [],
    this.episodes = 0,
    this.favorites = 0,
    this.genres = const [],
    this.image_url = '',
    this.mal_id = 0,
    this.members = 0,
    this.opening_themes = const [],
    this.popularity = 0,
    this.premiered = '',
    this.rank = 0,
    this.rating = '',
    this.score = 0,
    this.scored_by = 0,
    this.status = '',
    this.synopsis = '',
    this.title = '',
    this.title_english = '',
    this.title_japanese = '',
    this.trailer_url = '',
    this.type = '',
  });

  RawAired aired;
  bool airing;
  String background;
  String broadcast;
  String duration;
  List<String> ending_themes;
  int episodes;
  int favorites;
  List<RawGenre> genres;
  String image_url;
  int mal_id;
  int members;
  List<String> opening_themes;
  int popularity;
  String premiered;
  int rank;
  String rating;
  double score;
  int scored_by;
  String status;
  String synopsis;
  String title;
  String title_english;
  String title_japanese;
  String trailer_url;
  String type;

  factory RawAnime.fromJson(Map<String, dynamic> json) => _$RawAnimeFromJson(json);
  Map<String, dynamic> toJson() => _$RawAnimeToJson(this);
}

@JsonSerializable()
class RawAired {
  const RawAired({
    this.from = '',
    this.to = '',
  });

  final String from;
  final String to;

  factory RawAired.fromJson(Map<String, dynamic> json) => _$RawAiredFromJson(json);
  Map<String, dynamic> toJson() => _$RawAiredToJson(this);
}

@JsonSerializable()
class RawGenre {
  const RawGenre({
    this.mal_id = 0,
    this.name = '',
    this.type = '',
    this.url = '',
  });

  final int mal_id;
  final String name;
  final String type;
  final String url;

  factory RawGenre.fromJson(Map<String, dynamic> json) => _$RawGenreFromJson(json);
  Map<String, dynamic> toJson() => _$RawGenreToJson(this);
}
