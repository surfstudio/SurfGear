import 'package:flutter/material.dart';
import 'package:my_anime/models/aime_entity.dart';

class AnimeListElement extends StatelessWidget {
  final AnimeEntity anime;
  const AnimeListElement(this.anime, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Row(
        children: [
          SizedBox(
            child: Image.network(
              anime.imageUrl,
              fit: BoxFit.fitWidth,
            ),
            width: 150,
            height: 200,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      anime.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Text('Rank: ${anime.rank}'),
                  Text('Score: ${anime.score}'),
                  Text('Members: ${anime.members}'),
                  Text('Type: ${anime.type}'),
                  Text('Episodes: ${anime.episodes}'),
                  Text('Release Dates: ${anime.startDate} - ${anime.endDate}')
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
