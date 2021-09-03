import 'package:my_anime/interactors/anime_interactor.dart';
import 'package:surf_injector/surf_injector.dart';

class DetailsScreenComponent extends Component {
  int id;
  AnimeInteractor animeInteractor;

  DetailsScreenComponent(
    this.id,
    this.animeInteractor,
  );
}
