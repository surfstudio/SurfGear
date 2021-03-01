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
import 'package:mwwm_github_client/data/owner.dart';
import 'package:mwwm_github_client/data/repository.dart';
import 'package:mwwm_github_client/model/github/changes.dart';
import 'package:mwwm_github_client/model/github/repository/github_repository.dart';

class SearchRepositoriesPerformer
    extends FuturePerformer<List<Repository>, SearchRepositories> {
  SearchRepositoriesPerformer(this._githubRepository);

  final GithubRepository _githubRepository;

  @override
  Future<List<Repository>> perform(SearchRepositories change) {
    return _githubRepository.findRepositories(change.query);
  }
}

class GetRepositoriesPerformer
    extends FuturePerformer<List<Repository>, GetRepositories> {
  GetRepositoriesPerformer(this._githubRepository);

  final GithubRepository _githubRepository;

  @override
  Future<List<Repository>> perform(GetRepositories change) {
    return _githubRepository.getRepositories();
  }
}

class GetUsersPerformer extends FuturePerformer<List<Owner>, GetUsers> {
  GetUsersPerformer(this._githubRepository);

  final GithubRepository _githubRepository;

  @override
  Future<List<Owner>> perform(GetUsers change) {
    return _githubRepository.getUsers();
  }
}
