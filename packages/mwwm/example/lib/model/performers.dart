import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/data/repository.dart';
import 'package:mwwm_github_client/model/changes.dart';
import 'package:mwwm_github_client/model/repository/favorites_repository.dart';
import 'package:mwwm_github_client/model/repository/github_repository.dart';

/// Search repo by text
class SearchRepoPerformer
    extends FuturePerformer<List<Repository>, SearchRepos> {
  final GithubRepository _githubRepository;

  SearchRepoPerformer(this._githubRepository);

  @override
  Future<List<Repository>> perform(SearchRepos change) {
    return _githubRepository.getRepos(change.text);
  }
}

class ToggleFavoritePerformer
    extends FuturePerformer<Repository, ToggleFavorite> {
  ToggleFavoritePerformer();

  @override
  Future<Repository> perform(ToggleFavorite change) async {
    change.repo.isFavorite = change.isFavorite;

    return change.repo;
  }
}

class GetFavoritesPerformer extends Broadcast<List<Repository>, GetFavorites> {
  final FavoritesRepository _favoritesRepository;

  GetFavoritesPerformer(this._favoritesRepository);

  @override
  Future<List<Repository>> performInternal(GetFavorites change) {
    return _favoritesRepository.getAllRepos();
  }
}
