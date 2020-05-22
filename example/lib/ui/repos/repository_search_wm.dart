import 'dart:async';

import 'package:flutter/material.dart' as w;
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/model/changes.dart';
import 'package:mwwm_github_client/model/repository/response/reponses.dart';
import 'package:mwwm_github_client/ui/common/repo_item/repo_item.dart';
import 'package:relation/relation.dart';

/// Widget model for search repositories
/// todo: add actions and logic
class RepositorySearchWm extends WidgetModel {
  final StreamController<ListState> _reposController =
      StreamController.broadcast()..add(ListState.content([]));

  // final textController = w.TextEditingController(text: '');
  final textToSearchAction = TextEditingAction();

  final onAppBarTap = Action();
  final isSearching = StreamedState<bool>(false);

  final refresh = Action();

  Stream<ListState> get repos => _reposController.stream;

  RepositorySearchWm(WidgetModelDependencies baseDependencies, Model model)
      : super(baseDependencies, model: model);

  @override
  void onLoad() {
    super.onLoad();

    subscribe(
      textToSearchAction.stream,
      _searchRepos,
    );

    subscribe(
      onAppBarTap.stream,
      (_) {
        if (textToSearchAction.value?.isNotEmpty ?? false) {
          textToSearchAction.controller.text =
              ''; //todo: what to do with controller
        } else {
          isSearching.accept(!isSearching.value);
        }
      },
    );

    subscribe(refresh.stream, (_) {
      _searchRepos(textToSearchAction.value);
    });
  }

  void _searchRepos(String text) {
    try {

    
    _reposController.add(ListState.loading());

    doFuture(model.perform(SearchRepos(text)), (List<Repo> repos) {
      var uiModels = repos.map((r) => RepoItemUiModel(repository: r)).toList();
      _reposController.add(ListState.content(uiModels));
    }, onError: (_) {
      _reposController.add(ListState.error());
    });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _reposController.close();
    super.dispose();
  }
}

class ListState {
  final bool isLoading;
  final bool hasError;
  final List<RepoItemUiModel> data;

  bool get isDataEmpty => data.isEmpty;

  ListState(this.isLoading, this.hasError, this.data);

  ListState.content(List<RepoItemUiModel> data)
      : isLoading = false,
        hasError = false,
        this.data = data;

  ListState.loading()
      : isLoading = true,
        hasError = false,
        this.data = null;

  ListState.error()
      : isLoading = false,
        hasError = true,
        this.data = null;
}
