import 'package:json_annotation/json_annotation.dart';
import 'package:my_anime/data/raw_models/raw_anime_list_element.dart';

part 'raw_anime_top.g.dart';

@JsonSerializable()
class RawAnimeTop {
  List<RawAnimeListElement> top;

  RawAnimeTop({this.top = const []});

  factory RawAnimeTop.fromJson(Map<String, dynamic> json) => _$RawAnimeTopFromJson(json);
  Map<String, dynamic> toJson() => _$RawAnimeTopToJson(this);
}
