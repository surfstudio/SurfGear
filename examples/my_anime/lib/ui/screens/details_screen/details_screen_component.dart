import 'package:my_anime/repositories/anime_repository.dart';
import 'package:surf_injector/surf_injector.dart';

class DetailsScreenComponent extends Component {
  int id;
  AnimeRepository animeRepository;

  DetailsScreenComponent(
    this.id,
    this.animeRepository,
  );
}
