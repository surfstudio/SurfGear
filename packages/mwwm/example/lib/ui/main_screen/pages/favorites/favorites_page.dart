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
import 'package:mwwm_github_client/model/favorites/performers.dart';
import 'package:mwwm_github_client/model/favorites/repository/favorites_repository.dart';
import 'package:mwwm_github_client/ui/main_screen/pages/favorites/favorites_wm.dart';
import 'package:mwwm_github_client/ui/widgets/repository/repository_widget.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';

class FavoritesPage extends CoreMwwmWidget {
  FavoritesPage()
      : super(
          widgetModelBuilder: (context) => FavoritesWm(
            context.read<WidgetModelDependencies>(),
            Model([
              GetFavoriteRepositoriesPerformer(
                context.read<FavoritesRepository>(),
              ),
            ]),
          ),
        );

  @override
  State<StatefulWidget> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends WidgetState<FavoritesWm> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      );

  PreferredSizeWidget _buildAppBar() => AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
      );

  Widget _buildBody() {
    return EntityStateBuilder<List<Repository>>(
      streamedState: wm.favoritesState,
      child: (context, favorites) {
        if (favorites.isEmpty) {
          return _buildEmptyState();
        } else {
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final Repository repo = favorites[index];
              return RepositoryWidget(
                key: ValueKey(repo.id),
                repository: repo,
              );
            },
          );
        }
      },
      loadingBuilder: _buildLoadingState,
      errorBuilder: _buildError,
    );
  }

  Widget _buildEmptyState() {
    return const Center(child: Text('Empty'));
  }

  Widget _buildLoadingState(BuildContext context, _) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError(BuildContext context, _, __) {
    return const Center(child: Text('Error'));
  }
}
