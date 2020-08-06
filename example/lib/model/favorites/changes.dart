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

/// Switch repository's favorite value
class ToggleRepositoryFavoriteValue extends FutureChange<void> {
  ToggleRepositoryFavoriteValue(
    this.repo, {
    this.isFavorite,
  });

  final Repository repo;
  final bool isFavorite;
}

/// Receive favorite repositories
class GetFavoriteRepositories extends FutureChange<List<Repository>> {}

/// Check repository is favorites
class DefineFavoritesFromRepository extends FutureChange<List<Repository>> {
  DefineFavoritesFromRepository(this.repositories);

  final List<Repository> repositories;
}
