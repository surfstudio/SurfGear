import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/data/repository.dart';
import 'package:mwwm_github_client/model/favorites_repository/changes.dart';
import 'package:mwwm_github_client/model/github_repository/changes.dart';
import 'package:relation/relation.dart';

/// Widget model for search repositories
/// TODO: add actions and logic
class RepositoriesWm extends WidgetModel {
  RepositoriesWm(
    WidgetModelDependencies baseDependencies,
    Model model,
  ) : super(baseDependencies, model: model);

  /// Represent repositories from search request
  final repositoriesState = EntityStreamedState<List<Repository>>(
    EntityState.loading(),
  );

  /// Indicate search process
  final isSearchActiveState = StreamedState<bool>(false);

  /// Tap on search button
  final searchButtonTapAction = Action();

  /// Input search query
  final textQueryAction = TextEditingAction();

  /// Refresh requests
  final refreshAction = Action();

  @override
  void onLoad() {
    super.onLoad();

    _searchRepos('');
  }

  @override
  void onBind() {
    super.onBind();

    subscribe(
      searchButtonTapAction.stream,
      (_) => _setSearchActivationState(),
    );
    subscribe<String>(
      textQueryAction.stream,
      _searchRepos,
    );
    subscribe(
      refreshAction.stream,
      (_) => _searchRepos(textQueryAction.value),
    );
  }

  void _setSearchActivationState() {
    isSearchActiveState.accept(!isSearchActiveState.value);
  }

  Future<void> _searchRepos(String text) async {
    repositoriesState.loading();

    try {
      final FutureChange<List<Repository>> request = text?.isNotEmpty ?? false
          ? SearchRepositories(text)
          : GetRepositories();

      final List<Repository> repos = await model.perform(request);
      final List<Repository> favorites = await model.perform(
        GetFavoriteRepositories(),
      );

      for (var fav in favorites) {
        final Repository repo = repos.firstWhere((repo) => repo.id == fav.id);
        repo.isFavorite = true;
      }

      repositoriesState.content(repos);
    } on Exception catch (e) {
      handleError(e);
      repositoriesState.error(e);
    }
  }
}
