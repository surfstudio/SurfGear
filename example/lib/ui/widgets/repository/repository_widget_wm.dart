import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/data/repository.dart';
import 'package:mwwm_github_client/model/favorites/changes.dart';
import 'package:relation/relation.dart';

/// Repository widget's wm
class RepositoryWidgetWm extends WidgetModel {
  RepositoryWidgetWm(
    WidgetModelDependencies baseDependencies,
    Model model,
    Repository repo,
  ) : super(baseDependencies, model: model) {
    _init(repo);
  }

  /// Tap on favorite button
  final favoriteTapAction = Action<bool>();

  /// Is repository favorite indicator
  final isFavoriteState = StreamedState<bool>(false);

  /// Repository data
  final repoState = StreamedState<Repository>();

  @override
  void onBind() {
    super.onBind();

    subscribe(favoriteTapAction.stream, _handleFavoriteTap);
  }

  void _init(Repository repo) {
    repoState.accept(repo);
    isFavoriteState.accept(repo.isFavorite);
  }

  Future<void> _handleFavoriteTap(bool isFavorite) async {
    final Repository repo = repoState.value;
    repo.isFavorite = isFavorite;
    isFavoriteState.accept(isFavorite);

    try {
      await model.perform(
        ToggleRepositoryFavoriteValue(repo, isFavorite: isFavorite),
      );

      repoState.accept(repo);
    } on Exception catch (e) {
      handleError(e);
    }
  }
}

/// Emit events about favorites storage change
final favoritesChangedState = StreamedState<bool>();
