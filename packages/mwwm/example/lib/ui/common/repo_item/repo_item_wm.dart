import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/model/changes.dart';
import 'package:mwwm_github_client/model/repository/response/reponses.dart';
import 'package:relation/relation.dart';

class RepoItemWm extends WidgetModel {
  final addToFavorite = Action<bool>();
  final isFavorite = StreamedState<bool>(false);
  final repoState = StreamedState<Repo>();

  RepoItemWm(WidgetModelDependencies baseDependencies, Model model, Repo repo)
      : super(baseDependencies, model: model) {
    repoState.accept(repo);
    isFavorite.accept(repo.isFavorite);
  }

  @override
  void onLoad() {
    super.onLoad();

    subscribe(addToFavorite.stream, (isFavorite) {
      this.isFavorite.accept(!isFavorite);

      doFuture(
        model.perform(ToggleFavorite(repoState.value, isFavorite)),
        (repo) {
          repoState.accept(repo);
        },
      );
    });
  }
}
