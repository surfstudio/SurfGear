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
