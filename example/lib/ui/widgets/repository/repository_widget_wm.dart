import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/data/repository.dart';
import 'package:mwwm_github_client/model/changes.dart';
import 'package:relation/relation.dart';

/// Repository widget's wm
class RepositoryWidgetWm extends WidgetModel {
  /// Tap on favorite button
  final favoriteTapAction = Action<bool>();

  /// Is repository favorite indicator
  final isFavoriteState = StreamedState<bool>(false);

  /// Repository data
  final repoState = StreamedState<Repository>();

  RepositoryWidgetWm(
    WidgetModelDependencies baseDependencies,
    Model model,
    Repository repo,
  ) : super(baseDependencies, model: model) {
    _init(repo);
  }

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
    isFavoriteState.accept(!isFavorite);

    try {
      final Repository repo = await model.perform(
        ToggleFavorite(repoState.value, isFavorite),
      );
      repoState.accept(repo);
    } catch (e) {
      handleError(e);
    }
  }
}
