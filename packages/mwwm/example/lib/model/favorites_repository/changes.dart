import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/data/repository.dart';

/// Switch repository's favorite value
class ToggleRepositoryFavoriteValue extends FutureChange<Repository> {
  final Repository repo;
  final bool isFavorite;

  ToggleRepositoryFavoriteValue(this.repo, this.isFavorite);
}

/// Receive favorite repositories
class GetFavoriteRepositories extends FutureChange<List<Repository>> {}
