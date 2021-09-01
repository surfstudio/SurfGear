import 'package:json_annotation/json_annotation.dart';
import 'package:my_anime/data/raw_models/raw_anime_list_element.dart';

part 'raw_anime_top.g.dart';

@JsonSerializable()
class RawAnimeTop {
  RawAnimeTop({this.top = const []});

  List<RawAnimeListElement> top;

  factory RawAnimeTop.fromJson(Map<String, dynamic> json) => _$RawAnimeTopFromJson(json);
  Map<String, dynamic> toJson() => _$RawAnimeTopToJson(this);
}
