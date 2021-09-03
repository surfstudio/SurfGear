import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:my_anime/interactors/anime_interactor.dart';
import 'package:my_anime/models/aime_entity.dart';
import 'package:my_anime/ui/screens/details_screen/details_screen_component.dart';
import 'package:relation/relation.dart';
import 'package:surf_injector/surf_injector.dart';

DetailsScreenWM createDetailsScreenWM(BuildContext context) {
  final component = Injector.of<DetailsScreenComponent>(context).component;

  return DetailsScreenWM(
    component.id,
    component.animeInteractor,
  );
}

class DetailsScreenWM extends WidgetModel {
  final EntityStreamedState<AnimeEntity> details = EntityStreamedState()..loading();
  final int _id;
  final AnimeInteractor _interactor;

  DetailsScreenWM(
    this._id,
    this._interactor,
  ) : super(const WidgetModelDependencies());

  @override
  void onLoad() {
    super.onLoad();

    _loadDetails();
  }

  void addToFavorite() {
    final anime = details.value.data;
    anime!.isFavorite = true;
    details.content(anime);
    _interactor.addToFavorites(anime);
  }

  void deleteFromFavorite() {
    final anime = details.value.data;
    anime!.isFavorite = false;
    details.content(anime);
    _interactor.deleteFromFavorites(anime);
  }

  Future<void> _loadDetails() async {
    try {
      final data = await _interactor.getDetails(_id);
      await details.content(data);
    } on Exception catch (e) {
      await details.error(e);
    }
  }
}
