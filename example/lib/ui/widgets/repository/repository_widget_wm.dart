import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/model/changes.dart';
import 'package:mwwm_github_client/model/repository/response/responses.dart';
import 'package:relation/relation.dart';
import 'package:pedantic/pedantic.dart';

/// Repository widget's wm
class RepositoryWidgetWm extends WidgetModel {
  /// Tap on favorite button
  final favoriteTapAction = Action<bool>();

  /// Is repository favorite indicator
  final isFavoriteState = StreamedState<bool>(false);

  /// Repository data
  final repoState = StreamedState<Repo>();

  RepositoryWidgetWm(
    WidgetModelDependencies baseDependencies,
    Model model,
    Repo repo,
  ) : super(baseDependencies, model: model) {
    _init(repo);
  }

  @override
  void onBind() {
    super.onBind();

    subscribe(favoriteTapAction.stream, _handleFavoriteTap);
  }

  void _init(Repo repo) {
    repoState.accept(repo);
    isFavoriteState.accept(repo.isFavorite);
  }

  Future<void> _handleFavoriteTap(bool isFavorite) async {
    unawaited(isFavoriteState.accept(!isFavorite));

    try {
      final Repo repo = await model.perform(
        ToggleFavorite(repoState.value, isFavorite),
      );
      unawaited(repoState.accept(repo));
    } catch (e) {
      handleError(e);
    }
  }
}
