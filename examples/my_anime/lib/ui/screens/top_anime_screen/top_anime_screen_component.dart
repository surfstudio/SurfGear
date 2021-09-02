import 'package:my_anime/repositories/anime_repository.dart';
import 'package:surf_injector/surf_injector.dart';

class TopAnimeScreenComponent extends Component {
  TopAnimeScreenComponent(this.animeRepository);

  final AnimeRepository animeRepository;
}
