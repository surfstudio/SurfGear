import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/model/changes.dart';
import 'package:mwwm_github_client/model/repository/response/responses.dart';
import 'package:relation/relation.dart';
import 'package:pedantic/pedantic.dart';

/// Widget model for search repositories
/// TODO: add actions and logic
class RepositorySearchWm extends WidgetModel {
  /// Represent repositories from search request
  final EntityStreamedState<List<Repo>> repositoriesState =
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
    unawaited(repositoriesState.loading());

    try {
      final List<Repo> repos = await model.perform(SearchRepos(text));
      unawaited(repositoriesState.content(repos));
    } catch (e) {
      handleError(e);
      unawaited(repositoriesState.error(e));
    }
  }
}
