import 'package:dio/dio.dart';
import 'package:my_anime/data/api/jikan_api.dart';
import 'package:my_anime/data/mappers/anime_mapper.dart';
import 'package:my_anime/data/raw_models/raw_anime_top.dart';
import 'package:my_anime/models/aime_entity.dart';

class AnimeRepository {
  RestClient _client;

  AnimeRepository(this._client) {
    print('new rep');
  }

  Future<List<AnimeEntity>> getTop([int page = 1]) async {
    print('requesting animes');
    RawAnimeTop data = await _client.getAnimeTop(page.toString());
    return data.top.map((rawAnime) => AnimeMapper.rawAnimeListElementToEntity(rawAnime)).toList();
  }
}
