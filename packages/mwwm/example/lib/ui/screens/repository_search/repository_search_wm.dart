import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/data/repository.dart';
import 'package:mwwm_github_client/model/changes.dart';
import 'package:relation/relation.dart';

/// Widget model for search repositories
/// TODO: add actions and logic
class RepositorySearchWm extends WidgetModel {
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

  RepositorySearchWm(
    WidgetModelDependencies baseDependencies,
    Model model,
  ) : super(baseDependencies, model: model);

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
      final List<Repository> repos = await model.perform(SearchRepos(text));
      repositoriesState.content(repos);
    } catch (e) {
      handleError(e);
      repositoriesState.error(e);
    }
  }
}
