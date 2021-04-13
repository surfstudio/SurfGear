// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/data/repository.dart';
import 'package:mwwm_github_client/model/auth/changes.dart';
import 'package:mwwm_github_client/model/favorites/changes.dart';
import 'package:mwwm_github_client/model/github/changes.dart';
import 'package:mwwm_github_client/ui/login_screen/login_screen_route.dart';
import 'package:mwwm_github_client/ui/widgets/repository/repository_widget_wm.dart';
import 'package:relation/relation.dart';

/// Widget model for search repositories
class RepositoriesWm extends WidgetModel {
  RepositoriesWm(
    WidgetModelDependencies baseDependencies,
    Model model,
    this.controller,
  ) : super(baseDependencies, model: model);

  final DialogController controller;

  /// Represent repositories from search request
  final repositoriesState = EntityStreamedState<List<Repository>>(
    EntityState.loading(),
  );

  /// Indicate search process
  final isSearchActiveState = StreamedState<bool>(false);

  /// Tap on search button
  final searchButtonTapAction = Action();

  /// Input search query
  final textQueryAction = TextEditingAction();

  /// Refresh requests
  final refreshAction = Action();

  final exitAction = Action();

  @override
  void onLoad() {
    super.onLoad();

    _searchRepositories('');
  }

  @override
  void onBind() {
    super.onBind();

    subscribe(
      searchButtonTapAction.stream,
      (_) => _setSearchActivationState(),
    );
    subscribe<String>(
      textQueryAction.stream,
      _searchRepositories,
    );
    subscribe(
      refreshAction.stream,
      (_) => _searchRepositories(textQueryAction.value),
    );

    subscribe(
      exitAction.stream,
      (_) => _exit(),
    );

    subscribe(
      favoritesChangedState.stream,
      (_) => _checkFavorites(repositoriesState.value.data),
    );
  }

  void _setSearchActivationState() {
    isSearchActiveState.accept(!isSearchActiveState.value);
  }

  Future<void> _searchRepositories(String text) async {
    repositoriesState.loading();

    try {
      final FutureChange<List<Repository>> request = text?.isNotEmpty ?? false
          ? SearchRepositories(text)
          : GetRepositories();

      final List<Repository> repositories = await model.perform(request);

      _checkFavorites(repositories);
    } on Exception catch (e) {
      handleError(e);
      repositoriesState.error(e);
    }
  }

  Future<void> _checkFavorites(List<Repository> repositories) async {
    final List<Repository> checkedRepositories = await model.perform(
      DefineFavoritesFromRepository(repositories),
    );

    repositoriesState.content(checkedRepositories);
  }

  void _exit() {
    controller.showAlertDialog(
      title: 'Exit',
      message: 'Are you sure you want to exit?',
      onAgreeClicked: (context) async {
        try {
          await model.perform(DisconnectGithub());
          await Navigator.of(context)
              .pushAndRemoveUntil(LoginScreenRoute(), (route) => false);
        } on Exception catch (e) {
          handleError(e);
        }
      },
    );
  }
}
