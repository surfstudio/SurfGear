import 'package:flutter/cupertino.dart';
import 'package:my_anime/interactors/anime_interactor.dart';
import 'package:surf_injector/surf_injector.dart';

class TopAnimeScreenComponent extends Component {
  final AnimeInteractor animeInteractor;
  final NavigatorState navigator;

  TopAnimeScreenComponent(this.animeInteractor, this.navigator);
}
