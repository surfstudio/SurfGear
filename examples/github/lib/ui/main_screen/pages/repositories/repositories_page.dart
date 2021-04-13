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

import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/data/repository.dart';
import 'package:mwwm_github_client/model/auth/performers.dart';
import 'package:mwwm_github_client/model/auth/repository/auth_repository.dart';
import 'package:mwwm_github_client/model/common/error/standard_error_handler.dart';
import 'package:mwwm_github_client/model/favorites/performers.dart';
import 'package:mwwm_github_client/model/favorites/repository/favorites_repository.dart';
import 'package:mwwm_github_client/model/github/performers.dart';
import 'package:mwwm_github_client/model/github/repository/github_repository.dart';
import 'package:mwwm_github_client/ui/main_screen/pages/repositories/repositories_dialog_owner.dart';
import 'package:mwwm_github_client/ui/main_screen/pages/repositories/repositories_wm.dart';
import 'package:mwwm_github_client/ui/util/dialog_controller.dart';
import 'package:mwwm_github_client/ui/widgets/repository/repository_widget.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';

final _scaffoldKey = GlobalKey<ScaffoldState>();

/// Search repository screen
class RepositoriesPage extends CoreMwwmWidget {
  RepositoriesPage({
    Key key,
    WidgetModelBuilder widgetModelBuilder,
  }) : super(
          key: key,
          widgetModelBuilder: widgetModelBuilder ??
              (context) => RepositoriesWm(
                    WidgetModelDependencies(
                      errorHandler: StandardErrorHandler(_scaffoldKey),
                    ),
                    Model([
                      SearchRepositoriesPerformer(
                        context.read<GithubRepository>(),
                      ),
                      GetRepositoriesPerformer(
                        context.read<GithubRepository>(),
                      ),
                      DisconnectGithubPerformer(
                        context.read<AuthRepository>(),
                      ),
                      GetFavoriteRepositoriesPerformer(
                        context.read<FavoritesRepository>(),
                      ),
                      DefineFavoritesFromRepositoryPerformer(
                        context.read<FavoritesRepository>(),
                      )
                    ]),
                    DefaultDialogController(
                      _scaffoldKey,
                      dialogOwner: RepositoryDialogOwner(),
                    ),
                  ),
        );

  @override
  State<StatefulWidget> createState() {
    return _RepositoriesScreenState();
  }
}

class _RepositoriesScreenState extends WidgetState<RepositoriesWm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() => EntityStateBuilder<List<Repository>>(
        streamedState: wm.repositoriesState,
        errorBuilder: (ctx, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const Text('Произошла ошибка'),
              FlatButton(
                onPressed: wm.refreshAction,
                child: const Text('Обновить'),
              ),
            ],
          ),
        ),
        loadingBuilder: (ctx, _) => const Center(
          child: CircularProgressIndicator(),
        ),
        child: (ctx, repositories) {
          return ListView.builder(
            itemCount: repositories.length,
            itemBuilder: (ctx, i) {
              final Repository repo = repositories[i];

              return RepositoryWidget(
                key: ValueKey('${repo.id}-${repo.isFavorite}'),
                repository: repo,
              );
            },
          );
        },
      );

  PreferredSizeWidget _buildAppBar() => AppBar(
        centerTitle: true,
        title: _buildAppBarTitle(),
        leading: IconButton(
          icon: StreamedStateBuilder<bool>(
            streamedState: wm.isSearchActiveState,
            builder: (_, isSearching) {
              return Icon(isSearching ? Icons.clear : Icons.search);
            },
          ),
          onPressed: wm.searchButtonTapAction,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: wm.exitAction,
          ),
        ],
      );

  Widget _buildAppBarTitle() => StreamedStateBuilder<bool>(
        streamedState: wm.isSearchActiveState,
        builder: (ctx, isSearching) {
          return isSearching
              ? TextField(
                  controller: wm.textQueryAction.controller,
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                )
              : const Text('Search repository');
        },
      );
}
