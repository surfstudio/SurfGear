import 'package:my_anime/data/raw_models/raw_anime_list_element.dart';
import 'package:my_anime/models/aime_entity.dart';

class AnimeMapper {
  static AnimeEntity rawAnimeListElementToEntity(RawAnimeListElement raw) {
    return AnimeEntity(
      endDate: raw.end_date,
      startDate: raw.start_date,
      episodes: raw.episodes,
      imageUrl: raw.image_url,
      id: raw.mal_id,
      members: raw.members,
      rank: raw.rank,
      score: raw.score,
      title: raw.title,
      type: raw.type,
    );
  }
}
