import 'package:my_anime/data/api/jikan_api.dart';
import 'package:my_anime/data/mappers/anime_mapper.dart';
import 'package:my_anime/models/aime_entity.dart';

class AnimeRepository {
  final RestClient _client;

  AnimeRepository(this._client);

  Future<List<AnimeEntity>> getTop([int page = 1]) async {
    final data = await _client.getAnimeTop(page.toString());

    return data.top.map(AnimeMapper.rawAnimeListElementToEntity).toList();
  }

  Future<AnimeEntity> getDetails(int id) async {
    final data = await _client.getAnimeDetails(id.toString());

    return AnimeMapper.mapRawAnimeToEntity(data);
  }
}
