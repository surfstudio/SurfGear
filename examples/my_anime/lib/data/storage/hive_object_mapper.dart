import 'package:my_anime/data/storage/hive/anime_hive_object.dart';
import 'package:my_anime/models/aime_entity.dart';

class HiveObjectMapper {
  static AnimeHiveObject toHiveObject(AnimeEntity anime) {
    return AnimeHiveObject(
      anime.id,
      anime.endDate,
      anime.episodes,
      anime.imageUrl,
      anime.members,
      anime.rank,
      anime.score,
      anime.startDate,
      anime.title,
      anime.type,
    );
  }

  static AnimeEntity fromHiveObject(AnimeHiveObject anime) {
    return AnimeEntity(
      id: anime.id,
      endDate: anime.endDate,
      episodes: anime.episodes,
      imageUrl: anime.imageUrl,
      members: anime.members,
      rank: anime.rank,
      score: anime.score,
      startDate: anime.startDate,
      title: anime.title,
      type: anime.type,
    );
  }
}
