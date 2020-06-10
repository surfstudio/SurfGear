import 'package:flutter/material.dart';
import 'package:mwwm_github_client/ui/screens/favorites/favorites_route.dart';

class FavoritesButton extends StatelessWidget {
  FavoritesButton(this.favoriteCount);

  final int favoriteCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Center(
        child: IconButton(
          onPressed: () {
            Navigator.of(context).push(FavoritesRoute());
          },
          icon: Stack(
            children: <Widget>[
              Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              // buildFavoriteCount(), TODO: add this
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFavoriteCount() {
    if (favoriteCount > 0) {
      return Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Text(
          favoriteCount.toString(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return Container();
    }
  }
}
