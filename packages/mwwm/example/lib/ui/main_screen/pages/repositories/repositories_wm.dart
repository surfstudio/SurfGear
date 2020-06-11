import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/data/repository.dart';
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
  final EntityStreamedState<List<Repository>> repositoriesState =
      EntityStreamedState(EntityState.content([]));

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
      final request = text?.isNotEmpty ?? false
          ? SearchRepositories(text)
          : GetRepositories();

      final List<Repository> repos = await model.perform(request);
      repositoriesState.content(repos);
    } on Exception catch (e) {
      handleError(e);
      repositoriesState.error(e);
    }
  }
}
