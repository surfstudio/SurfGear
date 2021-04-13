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
import 'package:mwwm_github_client/model/github/changes.dart';
import 'package:relation/relation.dart';

/// Widget model for search repositories
class UsersWm extends WidgetModel {
  UsersWm(
    WidgetModelDependencies baseDependencies,
    Model model,
  ) : super(baseDependencies, model: model);

  /// Represent users
  final usersState = EntityStreamedState<List<Owner>>()..loading();

  /// Reload users
  final refreshAction = Action();

  @override
  void onLoad() {
    super.onLoad();

    _loadUsers();
  }

  @override
  void onBind() {
    super.onBind();

    subscribe(refreshAction.stream, (_) => _loadUsers());
  }

  Future<void> _loadUsers() async {
    usersState.loading();

    try {
      final List<Owner> users = await model.perform(GetUsers());
      usersState.content(users);
    } on Exception catch (e) {
      handleError(e);
    }
  }
}
