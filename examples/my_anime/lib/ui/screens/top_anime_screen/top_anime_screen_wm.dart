import 'package:flutter/cupertino.dart';
import 'package:mwwm/mwwm.dart';
import 'package:my_anime/models/aime_entity.dart';
import 'package:my_anime/repositories/anime_repository.dart';
import 'package:my_anime/ui/app/app_component.dart';
import 'package:relation/relation.dart';
import 'package:surf_injector/surf_injector.dart';

TopAnimeScreenWM createTopAnimeScreenWM(BuildContext context) {
  final component = Injector.of<AppComponent>(context).component;

  return TopAnimeScreenWM(
    component.animeRepository,
  );
}

class TopAnimeScreenWM extends WidgetModel {
  final scrollController = ScrollController();

  final listLoadingState = EntityStreamedState<Object>();
  final EntityStreamedState<List<AnimeEntity>> topAnimeState = EntityStreamedState()..content([]);

  final AnimeRepository _repository;

  int nextPage = 1;

  TopAnimeScreenWM(
    this._repository,
  ) : super(const WidgetModelDependencies()) {
    _loadNextAnimesPage();
  }

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

  Future<void> _loadNextAnimesPage() async {
    await listLoadingState.loading();
    try {
      final newElements = await _repository.getTop(nextPage);
      nextPage++;
      topAnimeState.value.data!.addAll(newElements);
      await topAnimeState.content(topAnimeState.value.data!);
      await listLoadingState.content(Object());
    } on Exception catch (e) {
      await listLoadingState.accept(EntityState.error(e, Object()));
    }
  }
}
