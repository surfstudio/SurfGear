import 'package:my_anime/repositories/anime_repository.dart';
import 'package:surf_injector/surf_injector.dart';

class AppComponent extends Component {
  AppComponent(this.animeRepository);

  final AnimeRepository animeRepository;
}
