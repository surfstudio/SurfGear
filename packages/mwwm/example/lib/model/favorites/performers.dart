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
import 'package:mwwm_github_client/model/favorites/repository/favorites_repository.dart';
import 'package:mwwm_github_client/ui/widgets/repository/repository_widget_wm.dart';

class ToggleRepositoryFavoriteValuePerformer
    extends FuturePerformer<void, ToggleRepositoryFavoriteValue> {
  ToggleRepositoryFavoriteValuePerformer(this._favoritesRepository);

  final FavoritesRepository _favoritesRepository;

  @override
  Future<void> perform(ToggleRepositoryFavoriteValue change) async {
    if (change.isFavorite) {
      await _favoritesRepository.add(change.repo);
    } else {
      await _favoritesRepository.delete(change.repo);
    }

    favoritesChangedState.accept(true);
  }
}

class GetFavoriteRepositoriesPerformer
    extends Broadcast<List<Repository>, GetFavoriteRepositories> {
  GetFavoriteRepositoriesPerformer(this._favoritesRepository);

  final FavoritesRepository _favoritesRepository;

  @override
  Future<List<Repository>> performInternal(GetFavoriteRepositories change) {
    return _favoritesRepository.getRepositories();
  }
}

class DefineFavoritesFromRepositoryPerformer
    extends FuturePerformer<List<Repository>, DefineFavoritesFromRepository> {
  DefineFavoritesFromRepositoryPerformer(this._favoritesRepository);

  final FavoritesRepository _favoritesRepository;

  @override
  Future<List<Repository>> perform(DefineFavoritesFromRepository change) async {
    final List<Repository> repositories = List.from(change?.repositories ?? []);
    final List<Repository> favorites =
        await _favoritesRepository.getRepositories();

    for (Repository repo in repositories) {
      repo.isFavorite = false;
    }

    for (Repository fav in favorites) {
      final Repository repo = repositories
          .firstWhere((repo) => repo.id == fav.id, orElse: () => null);
      repo?.isFavorite = true;
    }

    return repositories;
  }
}
