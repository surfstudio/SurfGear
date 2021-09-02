import 'package:flutter/cupertino.dart';
import 'package:mwwm/mwwm.dart';
import 'package:my_anime/models/aime_entity.dart';
import 'package:my_anime/repositories/anime_repository.dart';
import 'package:my_anime/ui/app/app_component.dart';
import 'package:relation/relation.dart';
import 'package:surf_injector/surf_injector.dart';

TopAnimeScreenWM createTopAnimeScreenWM(BuildContext context) {
  AppComponent component = Injector.of<AppComponent>(context).component;

  return TopAnimeScreenWM(component.animeRepository);
}

class TopAnimeScreenWM extends WidgetModel {
  TopAnimeScreenWM(
    this._repository,
  ) : super(const WidgetModelDependencies()) {
    _loadNextAnimesPage();
  }

  final AnimeRepository _repository;
  final EntityStreamedState<List<AnimeEntity>> topAnimeState = EntityStreamedState()..content([]);

  final scrollController = ScrollController();

  final listLoadingState = EntityStreamedState<Object>();

  int nextPage = 1;

  @override
  void onLoad() {
    super.onLoad();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent) {
      if (listLoadingState.value.isLoading) return;
      _loadNextAnimesPage();
    }
  }

  void _loadNextAnimesPage() {
    listLoadingState.loading();
    _repository.getTop(nextPage).then(
      (newElements) {
        nextPage++;
        topAnimeState.value.data!.addAll(newElements);
        topAnimeState.content(topAnimeState.value.data!);
        listLoadingState.content(Object());
      },
    ).catchError((dynamic e) => listLoadingState.accept(EntityState.error(e, Object())));
  }
}
