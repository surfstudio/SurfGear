import 'package:my_anime/data/api/jikan_api.dart';
import 'package:my_anime/repositories/anime_repository.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:dio/dio.dart';

class AppComponent extends Component {
  late final AnimeRepository animeRepository;

  AppComponent() {
    final dio = Dio();
    final client = RestClient(dio);
    animeRepository = AnimeRepository(client);
  }
}
