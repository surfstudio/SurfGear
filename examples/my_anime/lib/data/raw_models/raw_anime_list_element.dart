import 'package:json_annotation/json_annotation.dart';

part 'raw_anime_list_element.g.dart';

@JsonSerializable()
class RawAnimeListElement {
  String end_date;
  int episodes;
  String image_url;
  int mal_id;
  int members;
  int rank;
  double score;
  String start_date;
  String title;
  String type;

  RawAnimeListElement({
    required this.end_date,
    required this.episodes,
    required this.image_url,
    required this.mal_id,
    required this.members,
    required this.rank,
    required this.score,
    required this.start_date,
    required this.title,
    required this.type,
  });

  factory RawAnimeListElement.fromJson(Map<String, dynamic> json) => _$RawAnimeListElementFromJson(json);
  Map<String, dynamic> toJson() => _$RawAnimeListElementToJson(this);
}
