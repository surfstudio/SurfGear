import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/data/repository.dart';
import 'package:mwwm_github_client/model/favorites_repository/performers.dart';
import 'package:mwwm_github_client/model/favorites_repository/repository/favorites_repository.dart';
import 'package:mwwm_github_client/model/github_repository/performers.dart';
import 'package:mwwm_github_client/model/github_repository/repository/github_repository.dart';
import 'package:mwwm_github_client/ui/main_screen/pages/repositories/repositories_wm.dart';

import 'package:mwwm_github_client/ui/widgets/repository/repository_widget.dart';
import 'package:relation/relation.dart';
import 'package:provider/provider.dart';

/// Search repository screen
class RepositoriesPage extends CoreMwwmWidget {
  RepositoriesPage({
    Key key,
    WidgetModelBuilder widgetModelBuilder,
  }) : super(
          key: key,
          widgetModelBuilder: widgetModelBuilder ??
              (context) => RepositoriesWm(
                    context.read<WidgetModelDependencies>(),
                    Model([
                      SearchRepositoriesPerformer(
                        context.read<GithubRepository>(),
                      ),
                      GetRepositoriesPerformer(
                        context.read<GithubRepository>(),
                      ),
                      GetFavoriteRepositoriesPerformer(
                        context.read<FavoritesRepository>(),
                      )
                    ]),
                  ),
        );

  @override
  State<StatefulWidget> createState() {
    return _RepositoriesScreenState();
  }
}

class _RepositoriesScreenState extends WidgetState<RepositoriesWm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() => EntityStateBuilder<List<Repository>>(
        streamedState: wm.repositoriesState,
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
        child: (ctx, repositories) {
          return ListView.builder(
            itemCount: repositories.length,
            itemBuilder: (ctx, i) {
              final Repository repo = repositories[i];

              return RepositoryWidget(
                key: ValueKey('${repo.id}-${repo.isFavorite}'),
                repository: repo,
              );
            },
          );
        },
      );

  PreferredSizeWidget _buildAppBar() => AppBar(
        centerTitle: true,
        title: _buildAppBarTitle(),
        leading: IconButton(
          icon: StreamedStateBuilder<bool>(
            streamedState: wm.isSearchActiveState,
            builder: (_, isSearching) {
              return Icon(isSearching ? Icons.clear : Icons.search);
            },
          ),
          onPressed: wm.searchButtonTapAction,
        ),
      );

  Widget _buildAppBarTitle() => StreamedStateBuilder<bool>(
        streamedState: wm.isSearchActiveState,
        builder: (ctx, isSearching) {
          return isSearching
              ? TextField(
                  controller: wm.textQueryAction.controller,
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                )
              : const Text('search repos');
        },
      );
}
