import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_anime/data/storage/hive/anime_hive_object.dart';
import 'package:my_anime/data/storage/hive_object_mapper.dart';
import 'package:my_anime/models/aime_entity.dart';

class FavoritesStore {
  final _box = Hive.box<AnimeHiveObject>('favorites');

  List<AnimeEntity> get favorites => _box.values.map(HiveObjectMapper.fromHiveObject).toList();

  FavoritesStore();

  void addToFavorites(AnimeEntity anime) {
    _box.add(HiveObjectMapper.toHiveObject(anime));
  }

  void deleteFromFavorites(AnimeEntity anime) {
    final index = _box.values.toList().indexWhere((element) => element.id == anime.id);
    _box.deleteAt(index);
  }
}
