import 'package:my_anime/data/api/jikan_api.dart';
import 'package:my_anime/data/storage/favorites_store.dart';
import 'package:my_anime/data/storage/hive/hive_setup.dart';
import 'package:my_anime/interactors/anime_interactor.dart';
import 'package:my_anime/repositories/anime_repository.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:dio/dio.dart';

class AppComponent extends Component {
  late final AnimeInteractor animeInteractor;

  AppComponent() {
    final dio = Dio();
    final client = RestClient(dio);
    final animeRepository = AnimeRepository(client);
    final favoritesStore = FavoritesStore();
    animeInteractor = AnimeInteractor(animeRepository, favoritesStore);
  }
}
