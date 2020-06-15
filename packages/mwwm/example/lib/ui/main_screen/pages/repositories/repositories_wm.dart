import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/data/repository.dart';
import 'package:mwwm_github_client/model/favorites_repository/changes.dart';
import 'package:mwwm_github_client/model/github_repository/changes.dart';
import 'package:mwwm_github_client/ui/widgets/repository/repository_widget_wm.dart';
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

  final List<Repository> _cachedRepositories = [];

  @override
  void onLoad() {
    super.onLoad();

    _searchRepositories('');
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
      _searchRepositories,
    );
    subscribe(
      refreshAction.stream,
      (_) => _searchRepositories(textQueryAction.value),
    );

    subscribe(
      favoritesChangedState.stream,
      (_) => _checkFavorites(),
    );
  }

  void _setSearchActivationState() {
    isSearchActiveState.accept(!isSearchActiveState.value);
  }

  Future<void> _searchRepositories(String text) async {
    repositoriesState.loading();

    try {
      final FutureChange<List<Repository>> request = text?.isNotEmpty ?? false
          ? SearchRepositories(text)
          : GetRepositories();

      _cachedRepositories.clear();
      _cachedRepositories.addAll(await model.perform(request));

      _checkFavorites();
    } on Exception catch (e) {
      handleError(e);
      repositoriesState.error(e);
    }
  }

  Future<void> _checkFavorites() async {
    final List<Repository> favorites = await model.perform(
      GetFavoriteRepositories(),
    );

    for (Repository repo in _cachedRepositories) {
      repo.isFavorite = false;
    }

    for (Repository fav in favorites) {
      final Repository repo = _cachedRepositories.firstWhere(
        (repo) => repo.id == fav.id,
      );
      repo.isFavorite = true;
    }

    repositoriesState.content(_cachedRepositories);
  }
}
