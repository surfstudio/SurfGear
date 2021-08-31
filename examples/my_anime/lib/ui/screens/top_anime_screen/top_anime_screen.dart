import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:my_anime/models/aime_entity.dart';
import 'package:my_anime/ui/screens/top_anime_screen/top_anime_screen_wm.dart';
import 'package:my_anime/ui/widgets/anime_list_element.dart';
import 'package:relation/relation.dart';

class TopAnimeScreen extends CoreMwwmWidget<TopAnimeScreenWM> {
  TopAnimeScreen({Key? key})
      : super(
          key: key,
          widgetModelBuilder: createTopAnimeScreenWM,
        );
  @override
  WidgetState<TopAnimeScreen, TopAnimeScreenWM> createWidgetState() => _TopAnimeScreenState();
}

class _TopAnimeScreenState extends WidgetState<TopAnimeScreen, TopAnimeScreenWM> {
  @override
  Widget build(BuildContext context) => EntityStateBuilder<List<AnimeEntity>>(
        streamedState: wm.topAnimeState,
        loadingChild: const Center(
          child: CircularProgressIndicator(),
        ),
        builder: (_, animes) => Scaffold(
          appBar: AppBar(
            title: const Text('Top'),
          ),
          body: ListView.builder(
            itemBuilder: (_, idex) => AnimeListElement(animes[idex]),
            itemCount: animes.length,
          ),
        ),
      );
}
