import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/data/repository.dart';

/// Init search of repos
class SearchRepos extends FutureChange<List<Repository>> {
  final String text;

  SearchRepos(this.text);
}

class ToggleFavorite extends FutureChange<Repository> {
  final Repository repo;
  final isFavorite;

  ToggleFavorite(this.repo, this.isFavorite);
}

class GetFavorites extends FutureChange<List<Repository>> {}

class FavoriteCountChanges extends Change<int> {}
