import 'package:my_anime/data/raw_models/raw_anime_list_element.dart';
import 'package:my_anime/data/raw_models/raw_anime.dart';
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
  
  static AnimeEntity mapRawAnimeToEntity(RawAnime raw) {
    return AnimeEntity(
      dates: raw.aired?.string ?? '',
      airing: raw.airing ?? false,
      background: raw.background ?? '',
      broadcast: raw.broadcast ?? '',
      duration: raw.duration ?? '',
      endingThemes: raw.ending_themes ?? [],
      episodes: raw.episodes ?? 0,
      favorites: raw.favorites ?? 0,
      genres: raw.genres?.map((e) => e.name).toList() ?? [],
      imageUrl: raw.image_url ?? '',
      id: raw.mal_id ?? 0,
      members: raw.members ?? 0,
      openingThemes: raw.opening_themes ?? [],
      popularity: raw.popularity ?? 0,
      premiered: raw.premiered ?? '',
      rank: raw.rank ?? 0,
      rating: raw.rating ?? '',
      score: raw.score ?? 0,
      scoredBy: raw.scored_by ?? 0,
      status: raw.status ?? '',
      synopsis: raw.synopsis ?? '',
      title: raw.title ?? '',
      titleEnglish: raw.title_english ?? '',
      titleJapanese: raw.title_japanese ?? '',
      trailerUrl: raw.trailer_url ?? '',
      type: raw.type ?? '',
    );
  }
}
