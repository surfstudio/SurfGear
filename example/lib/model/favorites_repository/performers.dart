import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/data/repository.dart';
import 'package:mwwm_github_client/model/favorites_repository/changes.dart';
import 'package:mwwm_github_client/model/favorites_repository/repository/favorites_repository.dart';

class ToggleRepositoryFavoriteValuePerformer
    extends FuturePerformer<Repository, ToggleRepositoryFavoriteValue> {
  @override
  Future<Repository> perform(ToggleRepositoryFavoriteValue change) async {
    change.repo.isFavorite = change.isFavorite;

    // TODO save in db

    return change.repo;
  }
}

class GetFavoriteRepositoriesPerformer
    extends Broadcast<List<Repository>, GetFavoriteRepositories> {
  final FavoritesRepository _favoritesRepository;

  GetFavoriteRepositoriesPerformer(this._favoritesRepository);

  @override
  Future<List<Repository>> performInternal(GetFavoriteRepositories change) {
    return _favoritesRepository.getAllRepos();
  }
}
