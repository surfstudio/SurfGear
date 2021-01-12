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
import 'package:mwwm_github_client/data/owner.dart';
import 'package:mwwm_github_client/model/common/error/standard_error_handler.dart';
import 'package:mwwm_github_client/model/github/performers.dart';
import 'package:mwwm_github_client/model/github/repository/github_repository.dart';
import 'package:mwwm_github_client/ui/main_screen/pages/users/users_wm.dart';
import 'package:mwwm_github_client/ui/widgets/user_widget.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';

final _scaffoldKey = GlobalKey<ScaffoldState>();

/// Represent github-users
class UsersPage extends CoreMwwmWidget {
  UsersPage({
    Key key,
    WidgetModelBuilder widgetModelBuilder,
  }) : super(
          key: key,
          widgetModelBuilder: widgetModelBuilder ??
              (context) => UsersWm(
                    WidgetModelDependencies(
                      errorHandler: StandardErrorHandler(_scaffoldKey),
                    ),
                    Model([
                      GetUsersPerformer(
                        context.read<GithubRepository>(),
                      )
                    ]),
                  ),
        );

  @override
  State<StatefulWidget> createState() {
    return _UsersPageState();
  }
}

class _UsersPageState extends WidgetState<UsersWm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() => EntityStateBuilder<List<Owner>>(
        streamedState: wm.usersState,
        errorBuilder: (ctx, _, __) => Center(
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
        child: (ctx, users) {
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (ctx, i) {
              return UserWidget(user: users[i]);
            },
          );
        },
      );

  PreferredSizeWidget _buildAppBar() => AppBar(
        centerTitle: true,
        title: const Text('Users'),
      );
}
