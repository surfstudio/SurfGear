import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:my_anime/models/aime_entity.dart';
import 'package:my_anime/ui/screens/details_screen/details_screen_wm.dart';
import 'package:relation/relation.dart';

class DetailsScreen extends CoreMwwmWidget<DetailsScreenWM> {
  const DetailsScreen({Key? key})
      : super(
          key: key,
          widgetModelBuilder: createDetailsScreenWM,
        );
  @override
  WidgetState<DetailsScreen, DetailsScreenWM> createWidgetState() => _DetailsScreenState();
}

class _DetailsScreenState extends WidgetState<DetailsScreen, DetailsScreenWM> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Details'),
        ),
        body: EntityStateBuilder<AnimeEntity>(
          streamedState: wm.details,
          errorBuilder: (_, __) => const Center(
            child: Text('Error while fetching data'),
          ),
          builder: (_, anime) => _AnimeDetails(anime),
        ),
      );
}

class _AnimeDetails extends StatelessWidget {
  final AnimeEntity anime;
  const _AnimeDetails(this.anime, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Image.network(
              anime.imageUrl,
              fit: BoxFit.fitWidth,
            ),
          ),
          _DetailsStringElement('Title:', anime.title),
          _DetailsStringElement('Japanese title:', anime.titleJapanese),
          _DetailsStringElement('Synopsis:', anime.synopsis),
          _DetailsStringElement(
            'Genres:',
            anime.genres.join(', '),
          ),
          _DetailsStringElement('Release dates:', anime.dates),
          _DetailsStringElement('Airing:', anime.airing ? 'No' : 'Yes'),
          _DetailsStringElement('Background:', anime.background),
          _DetailsStringElement('Broadcast:', anime.broadcast),
          _DetailsStringElement('Duration:', anime.duration),
          _DetailsStringElement('Episodes:', anime.episodes.toString()),
          _DetailsStringElement('Favorites:', anime.favorites.toString()),
          _DetailsStringElement('Members:', anime.members.toString()),
          _DetailsStringElement('Popularity:', anime.popularity.toString()),
          _DetailsStringElement('Premiered:', anime.premiered),
          _DetailsStringElement('Rank:', anime.rank.toString()),
          _DetailsStringElement('Rating:', anime.rating),
          _DetailsStringElement('Score:', anime.score.toString()),
          _DetailsStringElement('Scored by:', anime.scoredBy.toString()),
          _DetailsStringElement('Status:', anime.status),
          _DetailsStringElement('Type:', anime.type),
          _DetailsStringListElement('Opening themes:', anime.openingThemes),
          _DetailsStringListElement('Ending themes:', anime.endingThemes),
        ],
      ),
    );
  }
}

class _DetailsStringElement extends StatelessWidget {
  final String title;
  final String value;

  const _DetailsStringElement(this.title, this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _DetailsColumn(
      children: [
        _Title(title),
        const SizedBox(
          height: 5,
        ),
        _Value(value),
      ],
    );
  }
}

class _DetailsStringListElement extends StatelessWidget {
  final String title;
  final List<String> value;

  const _DetailsStringListElement(this.title, this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _DetailsColumn(
      children: [
        _Title(title),
        const SizedBox(
          height: 5,
        ),
        ...value.map((e) => _Value(e))..toList(),
      ],
    );
  }
}

class _DetailsColumn extends StatelessWidget {
  final List<Widget> children;

  const _DetailsColumn({required this.children, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white54,
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String title;

  const _Title(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 16,
      ),
    );
  }
}

class _Value extends StatelessWidget {
  final String value;

  const _Value(this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    );
  }
}
