import 'package:json_annotation/json_annotation.dart';

part 'raw_anime_list_element.g.dart';

@JsonSerializable()
class RawAnimeListElement {
  RawAnimeListElement({
    this.end_date = '',
    this.episodes = 0,
    this.image_url = '',
    this.mal_id = -1,
    this.members = 0,
    this.rank = 0,
    this.score = 0,
    this.start_date = '',
    this.title = '',
    this.type = '',
  });

  String? end_date;
  int? episodes;
  String? image_url;
  int? mal_id;
  int? members;
  int? rank;
  double? score;
  String? start_date;
  String? title;
  String? type;

  factory RawAnimeListElement.fromJson(Map<String, dynamic> json) => _$RawAnimeListElementFromJson(json);
  Map<String, dynamic> toJson() => _$RawAnimeListElementToJson(this);
}
