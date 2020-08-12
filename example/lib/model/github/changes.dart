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

/// Search github repositories by query [query]
class SearchRepositories extends FutureChange<List<Repository>> {
  SearchRepositories(this.query);

  final String query;
}

/// Get all repositories.
class GetRepositories extends FutureChange<List<Repository>> {}

/// Get All Users
class GetUsers extends FutureChange<List<Owner>> {}
