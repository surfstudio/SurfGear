import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/model/performers.dart';
import 'package:mwwm_github_client/model/repository/github_repository.dart';
import 'package:mwwm_github_client/ui/screens/repository_search/repository_search_screen.dart';
import 'package:mwwm_github_client/ui/screens/repository_search/repository_search_wm.dart';
import 'package:provider/provider.dart';

/// Route for search repository screen
class RepositorySearchRoute extends MaterialPageRoute {
  RepositorySearchRoute()
      : super(
          builder: (context) => RepositorySearchScreen(
            widgetModelBuilder: (context) => RepositorySearchWm(
              context.read<WidgetModelDependencies>(),
              Model([
                SearchRepoPerformer(
                  context.read<GithubRepository>(),
                ),
              ]),
            ),
          ),
        );
}
