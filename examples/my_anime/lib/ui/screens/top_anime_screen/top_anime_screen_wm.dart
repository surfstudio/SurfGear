import 'package:flutter/cupertino.dart';
import 'package:mwwm/mwwm.dart';
import 'package:my_anime/interactors/anime_interactor.dart';
import 'package:my_anime/models/aime_entity.dart';
import 'package:my_anime/ui/screens/details_screen/details_screen_roure.dart';
import 'package:my_anime/ui/screens/top_anime_screen/top_anime_screen_component.dart';
import 'package:relation/relation.dart';
import 'package:surf_injector/surf_injector.dart';

TopAnimeScreenWM createTopAnimeScreenWM(BuildContext context) {
  final component = Injector.of<TopAnimeScreenComponent>(context).component;

  return TopAnimeScreenWM(
    component.animeInteractor,
    component.navigator,
  );
}

class TopAnimeScreenWM extends WidgetModel {
  final scrollController = ScrollController();

  final listLoadingState = EntityStreamedState<Object>();
  final EntityStreamedState<List<AnimeEntity>> topAnimeState = EntityStreamedState()..content([]);

  final AnimeInteractor _interactor;
  final NavigatorState _navigator;

  int nextPage = 1;

  TopAnimeScreenWM(
    this._interactor,
    this._navigator,
  ) : super(const WidgetModelDependencies()) {
    _loadNextAnimesPage();
  }

  @override
  void onLoad() {
    super.onLoad();
    scrollController.addListener(_onScroll);
  }

  void onAnimeTap(int id) {
    _navigator.push(DetailsScreenRoute(id));
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
      final newElements = await _interactor.getTop(nextPage);
      nextPage++;
      topAnimeState.value.data!.addAll(newElements);
      await topAnimeState.content(topAnimeState.value.data!);
      await listLoadingState.content(Object());
    } on Exception catch (e) {
      await listLoadingState.accept(EntityState.error(e, Object()));
    }
  }
}
