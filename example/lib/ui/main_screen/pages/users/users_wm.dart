import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/data/owner.dart';
import 'package:mwwm_github_client/model/github/changes.dart';
import 'package:relation/relation.dart';

/// Widget model for search repositories
class UsersWm extends WidgetModel {
  UsersWm(
    WidgetModelDependencies baseDependencies,
    Model model,
  ) : super(baseDependencies, model: model);

  /// Represent users
  final usersState = EntityStreamedState<List<Owner>>()..loading();

  /// Reload users
  final refreshAction = Action();

  @override
  void onLoad() {
    super.onLoad();

    _loadUsers();
  }

  @override
  void onBind() {
    super.onBind();

    subscribe(refreshAction.stream, (_) => _loadUsers());
  }

  Future<void> _loadUsers() async {
    usersState.loading();

    try {
      final List<Owner> users = await model.perform(GetUsers());
      usersState.content(users);
    } on Exception catch (e) {
      handleError(e);
    }
  }
}
