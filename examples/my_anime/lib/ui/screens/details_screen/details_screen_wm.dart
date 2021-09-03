import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:my_anime/models/aime_entity.dart';
import 'package:my_anime/repositories/anime_repository.dart';
import 'package:my_anime/ui/screens/details_screen/details_screen_component.dart';
import 'package:relation/relation.dart';
import 'package:surf_injector/surf_injector.dart';

DetailsScreenWM createDetailsScreenWM(BuildContext context) {
  final component = Injector.of<DetailsScreenComponent>(context).component;

  return DetailsScreenWM(
    component.id,
    component.animeRepository,
  );
}

class DetailsScreenWM extends WidgetModel {
  final EntityStreamedState<AnimeEntity> details = EntityStreamedState()..loading();
  final int _id;
  final AnimeRepository _repository;

  DetailsScreenWM(
    this._id,
    this._repository,
  ) : super(const WidgetModelDependencies());

  @override
  void onLoad() {
    super.onLoad();

    _loadDetails();
  }

  Future<void> _loadDetails() async {
    try {
      final data = await _repository.getDetails(_id);
      await details.content(data);
    } on Exception catch (e) {
      await details.error(e);
    }
  }
}
