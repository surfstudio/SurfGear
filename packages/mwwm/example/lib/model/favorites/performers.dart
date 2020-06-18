import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/data/repository.dart';
import 'package:mwwm_github_client/model/favorites/changes.dart';
import 'package:mwwm_github_client/model/favorites/repository/favorites_repository.dart';
import 'package:mwwm_github_client/ui/widgets/repository/repository_widget_wm.dart';

class ToggleRepositoryFavoriteValuePerformer
    extends FuturePerformer<void, ToggleRepositoryFavoriteValue> {
  ToggleRepositoryFavoriteValuePerformer(this._favoritesRepository);

  final FavoritesRepository _favoritesRepository;

  @override
  Future<void> perform(ToggleRepositoryFavoriteValue change) async {
    if (change.isFavorite) {
      await _favoritesRepository.add(change.repo);
    } else {
      await _favoritesRepository.delete(change.repo);
    }

    favoritesChangedState.accept(true);
  }
}

class GetFavoriteRepositoriesPerformer
    extends Broadcast<List<Repository>, GetFavoriteRepositories> {
  GetFavoriteRepositoriesPerformer(this._favoritesRepository);

  final FavoritesRepository _favoritesRepository;

  @override
  Future<List<Repository>> performInternal(GetFavoriteRepositories change) {
    return _favoritesRepository.getRepositories();
  }
}

class DefineFavoritesFromRepositoryPerformer
    extends FuturePerformer<List<Repository>, DefineFavoritesFromRepository> {
  DefineFavoritesFromRepositoryPerformer(this._favoritesRepository);

  final FavoritesRepository _favoritesRepository;

  @override
  Future<List<Repository>> perform(DefineFavoritesFromRepository change) async {
    final List<Repository> repositories = List.from(change.repositories);
    final List<Repository> favorites =
        await _favoritesRepository.getRepositories();

    for (Repository repo in repositories) {
      repo.isFavorite = false;
    }

    for (Repository fav in favorites) {
      final Repository repo = repositories.firstWhere(
        (repo) => repo.id == fav.id,
      );
      repo.isFavorite = true;
    }

    return repositories;
  }
}
