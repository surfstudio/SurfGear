import 'dart:async';

import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/model/changes.dart';
import 'package:mwwm_github_client/model/repository/response/reponses.dart';
import 'package:mwwm_github_client/ui/common/repo_item/repo_item.dart';
import 'package:relation/relation.dart';

/// Widget model for search repositories
/// todo: add actions and logic
class RepositorySearchWm extends WidgetModel {
  final EntityStreamedState<List<RepoItemUiModel>> repos =
      EntityStreamedState(EntityState.content([]));
  final isSearching = StreamedState<bool>(false);

  final onAppBarTap = Action();
  final textToSearch = TextEditingAction();
  final refresh = Action();

  RepositorySearchWm(WidgetModelDependencies baseDependencies, Model model)
      : super(baseDependencies, model: model);

  @override
  void onBind() {
    super.onBind();

    subscribe(onAppBarTap.stream, (_) {
      isSearching.accept(!isSearching.value);
    });

    subscribe<String>(
      textToSearch.stream,
      _searchRepos,
    );

    subscribe(refresh.stream, (_) => _searchRepos(textToSearch.value));
  }

  void _searchRepos(String text) {
    repos.loading();

    doFutureHandleError<List<Repo>>(
      model.perform(SearchRepos(text)),
      (repos) {
        var uiModel = repos.map((r) => RepoItemUiModel(repository: r)).toList();
        this.repos.content(uiModel);
      },
      onError: (e) {
        repos.error(e);
      },
    );
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
