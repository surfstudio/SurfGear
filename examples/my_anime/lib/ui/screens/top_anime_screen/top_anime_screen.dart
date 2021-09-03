import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:my_anime/models/aime_entity.dart';
import 'package:my_anime/ui/screens/top_anime_screen/top_anime_screen_wm.dart';
import 'package:my_anime/ui/widgets/anime_list_element.dart';
import 'package:relation/relation.dart';

class TopAnimeScreen extends CoreMwwmWidget<TopAnimeScreenWM> {
  const TopAnimeScreen({Key? key})
      : super(
          key: key,
          widgetModelBuilder: createTopAnimeScreenWM,
        );
  @override
  WidgetState<TopAnimeScreen, TopAnimeScreenWM> createWidgetState() => _TopAnimeScreenState();
}

class _TopAnimeScreenState extends WidgetState<TopAnimeScreen, TopAnimeScreenWM> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Top'),
        ),
        body: EntityStateBuilder<List<AnimeEntity>>(
          streamedState: wm.topAnimeState,
          loadingChild: const Center(
            child: CircularProgressIndicator(),
          ),
          errorBuilder: (_, e) => Center(
            child: Text('Error: $e'),
          ),
          builder: (_, animes) => ListView.builder(
            physics: const BouncingScrollPhysics(),
            controller: wm.scrollController,
            padding: const EdgeInsets.all(4),
            itemCount: animes.length + 1,
            itemBuilder: (_, index) => index == animes.length
                ? EntityStateBuilder<Object>(
                    streamedState: wm.listLoadingState,
                    errorBuilder: (_, e) => const SizedBox(
                      height: 64,
                      child: Center(child: Text('Error while fetching data')),
                    ),
                    loadingChild: const SizedBox(
                      height: 64,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    builder: (_, __) => const SizedBox(
                      height: 64,
                    ),
                  )
                : AnimeListElement(
                    animes[index],
                    onTap: wm.onAnimeTap,
                  ),
          ),
        ),
      );
}
