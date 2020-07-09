import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/data/repository.dart';
import 'package:mwwm_github_client/model/favorites/changes.dart';
import 'package:mwwm_github_client/ui/widgets/repository/repository_widget_wm.dart';
import 'package:relation/relation.dart';

/// Widget model for search repositories
/// todo: add actions and logic
class FavoritesWm extends WidgetModel {
  FavoritesWm(
    WidgetModelDependencies baseDependencies,
    Model model,
  ) : super(baseDependencies, model: model);

  final favoritesState = EntityStreamedState<List<Repository>>(
    EntityState.loading(),
  );

  @override
  void onLoad() {
    super.onLoad();

    _loadFavorites();
  }

  @override
  void onBind() {
    super.onBind();

    subscribe(
      favoritesChangedState.stream,
      (_) => _loadFavorites(),
    );
  }

  Future<void> _loadFavorites() async {
    favoritesState.loading();

    try {
      final List<Repository> favorites = await model.perform(
        GetFavoriteRepositories(),
      );
      favoritesState.content(favorites);
    } on Exception catch (e) {
      handleError(e);
      favoritesState.error(e);
    }
  }
}
