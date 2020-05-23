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

  RepositorySearchWm(WidgetModelDependencies baseDependencies, Model model)
      : super(baseDependencies, model: model);

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
