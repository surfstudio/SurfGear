import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/data/owner.dart';
import 'package:mwwm_github_client/model/github/performers.dart';
import 'package:mwwm_github_client/model/github/repository/github_repository.dart';
import 'package:mwwm_github_client/ui/main_screen/pages/repositories/repositories_wm.dart';
import 'package:mwwm_github_client/ui/main_screen/pages/users/users_wm.dart';
import 'package:mwwm_github_client/ui/widgets/user_widget.dart';

import 'package:relation/relation.dart';
import 'package:provider/provider.dart';

/// Represent github-users
class UsersPage extends CoreMwwmWidget {
  UsersPage({
    Key key,
    WidgetModelBuilder widgetModelBuilder,
  }) : super(
          key: key,
          widgetModelBuilder: widgetModelBuilder ??
              (context) => UsersWm(
                    context.read<WidgetModelDependencies>(),
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
