import 'package:flutter/cupertino.dart';
import 'package:mwwm/mwwm.dart';
import 'package:my_anime/models/aime_entity.dart';
import 'package:my_anime/repositories/anime_repository.dart';
import 'package:my_anime/ui/screens/top_anime_screen/top_anime_screen_component.dart';
import 'package:relation/relation.dart';
import 'package:surf_injector/surf_injector.dart';

TopAnimeScreenWM createTopAnimeScreenWM(BuildContext context) {
  TopAnimeScreenComponent component = Injector.of<TopAnimeScreenComponent>(context).component;
  return TopAnimeScreenWM(component.animeRepository);
}

class TopAnimeScreenWM extends WidgetModel {
  final AnimeRepository _repository;
  final EntityStreamedState<List<AnimeEntity>> _topAnimeState = EntityStreamedState(EntityState.loading());

  TopAnimeScreenWM(
    this._repository,
  ) : super(const WidgetModelDependencies()) {
    _repository.getTop().then((data) => _topAnimeState.accept(EntityState.content(data))).catchError((error) {
      print(error);
      return error;
    });
  }
  EntityStreamedState<List<AnimeEntity>> get topAnimeState => _topAnimeState;
}
