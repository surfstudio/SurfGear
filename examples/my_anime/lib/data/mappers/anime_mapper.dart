import 'package:my_anime/data/raw_models/raw_anime_list_element.dart';
import 'package:my_anime/models/aime_entity.dart';

class AnimeMapper {
  static AnimeEntity rawAnimeListElementToEntity(RawAnimeListElement raw) {
    return AnimeEntity(
      endDate: raw.end_date ?? '',
      startDate: raw.start_date ?? '',
      episodes: raw.episodes ?? 0,
      imageUrl: raw.image_url ?? '',
      id: raw.mal_id ?? -1,
      members: raw.members ?? 0,
      rank: raw.rank ?? 0,
      score: raw.score ?? 0,
      title: raw.title ?? '',
      type: raw.type ?? '',
    );
  }
}
