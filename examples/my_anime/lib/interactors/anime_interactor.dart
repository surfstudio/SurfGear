import 'package:my_anime/data/storage/favorites_store.dart';
import 'package:my_anime/models/aime_entity.dart';
import 'package:my_anime/repositories/anime_repository.dart';

class AnimeInteractor {
  final AnimeRepository _repository;
  final FavoritesStore _store;

  AnimeInteractor(this._repository, this._store);

  Future<List<AnimeEntity>> getTop([int page = 1]) {
    return _repository.getTop(page);
  }

  Future<AnimeEntity> getDetails(int id) async {
    final isFavorite = _store.favorites.any((element) => element.id == id);
    final details = await _repository.getDetails(id);
    details.isFavorite = isFavorite;
    return details;
  }

  void addToFavorites(AnimeEntity anime) {
    _store.addToFavorites(anime);
  }

  void deleteFromFavorites(AnimeEntity anime) {
    _store.deleteFromFavorites(anime);
  }
}
