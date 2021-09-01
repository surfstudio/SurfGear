import 'package:flutter/material.dart';
import 'package:my_anime/models/aime_entity.dart';

class AnimeListElement extends StatelessWidget {
  final AnimeEntity anime;
  const AnimeListElement(this.anime, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10,
      child: SizedBox(
        height: 200,
        child: Row(
          children: [
            SizedBox(
              child: Image.network(
                anime.imageUrl,
                fit: BoxFit.cover,
              ),
              width: 150,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _Title(anime.title),
                    ),
                    _Subtitle('Rank', anime.rank.toString()),
                    _Subtitle('Score', anime.score.toString()),
                    _Subtitle('Members', anime.members.toString()),
                    _Subtitle('Type', anime.type),
                    _Subtitle('Episodes', anime.episodes.toString()),
                    _Subtitle('Release Dates', '${anime.startDate} - ${anime.endDate}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title(this._title, {Key? key}) : super(key: key);

  final String _title;

  @override
  Widget build(BuildContext context) {
    return Text(
      _title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 20,
      ),
    );
  }
}

class _Subtitle extends StatelessWidget {
  const _Subtitle(this._subtitle, this._value, {Key? key}) : super(key: key);

  final String _subtitle;
  final String _value;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_subtitle: $_value',
      style: const TextStyle(
        fontSize: 15,
        color: Colors.white60,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
