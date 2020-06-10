import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/model/github_repository/performers.dart';
import 'package:mwwm_github_client/model/github_repository/repository/github_repository.dart';
import 'package:mwwm_github_client/ui/screens/repository_search/repository_search_screen.dart';
import 'package:mwwm_github_client/ui/screens/repository_search/repository_search_wm.dart';
import 'package:provider/provider.dart';

/// Route for search repository screen
class RepositorySearchRoute extends MaterialPageRoute {
  RepositorySearchRoute()
      : super(
          builder: (context) => RepositorySearchScreen(
            widgetModelBuilder: _buildWm,
          ),
        );
}

WidgetModel _buildWm(BuildContext context) => RepositorySearchWm(
      context.read<WidgetModelDependencies>(),
      Model([
        SearchRepositoriesPerformer(
          context.read<GithubRepository>(),
        ),
        GetRepositoriesPerformer(
          context.read<GithubRepository>(),
        )
      ]),
    );
