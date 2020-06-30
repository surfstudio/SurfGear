import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/data/repository.dart';

/// Switch repository's favorite value
class ToggleRepositoryFavoriteValue extends FutureChange<void> {
  ToggleRepositoryFavoriteValue(
    this.repo, {
    this.isFavorite,
  });

  final Repository repo;
  final bool isFavorite;
}

/// Receive favorite repositories
class GetFavoriteRepositories extends FutureChange<List<Repository>> {}

/// Check repository is favorites
class DefineFavoritesFromRepository extends FutureChange<List<Repository>> {
  DefineFavoritesFromRepository(this.repositories);

  final List<Repository> repositories;
}
