import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/data/repository.dart';
import 'package:mwwm_github_client/model/github/changes.dart';
import 'package:mwwm_github_client/model/github/repository/github_repository.dart';

class SearchRepositoriesPerformer
    extends FuturePerformer<List<Repository>, SearchRepositories> {
  SearchRepositoriesPerformer(this._githubRepository);

  final GithubRepository _githubRepository;

  @override
  Future<List<Repository>> perform(SearchRepositories change) {
    return _githubRepository.findRepositories(change.query);
  }
}

class GetRepositoriesPerformer
    extends FuturePerformer<List<Repository>, GetRepositories> {
  GetRepositoriesPerformer(this._githubRepository);

  final GithubRepository _githubRepository;

  @override
  Future<List<Repository>> perform(GetRepositories change) {
    return _githubRepository.getRepositories();
  }
}
