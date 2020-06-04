import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/model/changes.dart';
import 'package:mwwm_github_client/model/repository/favorites_repository.dart';
import 'package:mwwm_github_client/model/repository/github_repository.dart';
import 'package:mwwm_github_client/model/repository/response/reponses.dart';

/// Search repo by text
class SearchRepoPerformer extends FuturePerformer<List<Repo>, SearchRepos> {
  final GithubRepository _githubRepository;

  SearchRepoPerformer(this._githubRepository);

  @override
  Future<List<Repo>> perform(SearchRepos change) {
    return _githubRepository.getRepos(change.text);
  }
}

class ToggleFavoritePerformer extends FuturePerformer<Repo, ToggleFavorite> {

  ToggleFavoritePerformer();

  @override
  Future<Repo> perform(ToggleFavorite change) async {
    change.repo.isFavorite = change.isFavorite;

    return change.repo;
  }
}

class GetFavoritesPerformer extends Broadcast<List<Repo>, GetFavorites> {
  final FavoritesRepository _favoritesRepository;

  GetFavoritesPerformer(this._favoritesRepository);

  @override
  Future<List<Repo>> performInternal(GetFavorites change) {
    return _favoritesRepository.getAllRepos();
  }
}
