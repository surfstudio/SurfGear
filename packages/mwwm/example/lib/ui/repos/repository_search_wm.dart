import 'dart:async';

import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/model/service/response/reponses.dart';

/// Widget model for search repositories
/// todo: add actions and logic
class RepositorySearchWm extends WidgetModel {
  String _textToSearch = "";

  final StreamController<List<Repo>> _reposController =
      StreamController.broadcast()..add([]);

  Stream<List<Repo>> _repos;

  RepositorySearchWm(WidgetModelDependencies baseDependencies, Model model)
      : super(baseDependencies) {
    _repos = _reposController.stream;
  }

  @override
  void onLoad() {
    super.onLoad();

  }


@override
  void dispose() {
    _reposController.close();
    super.dispose();
  }

}
