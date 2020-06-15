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
    return _favoritesRepository.getAllRepos();
  }
}
