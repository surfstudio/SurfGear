import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/model/performers.dart';
import 'package:mwwm_github_client/model/repository/github_repository.dart';

import 'package:mwwm_github_client/model/repository/response/reponses.dart';
import 'package:mwwm_github_client/ui/common/repo_item/repo_item.dart';
import 'package:mwwm_github_client/ui/repos/widgets/favorites_button.dart';
import 'package:mwwm_github_client/ui/repos/repository_search_wm.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';

class RepositorySearchScreen extends CoreMwwmWidget {
  RepositorySearchScreen({
    WidgetModelBuilder wmBuilder,
  }) : super(
          widgetModelBuilder: wmBuilder ??
              (ctx) => RepositorySearchWm(
                    ctx.read<WidgetModelDependencies>(),
                    Model([SearchRepoPerformer(ctx.read<GithubRepository>())]),
                  ),
        );

  @override
  State<StatefulWidget> createState() {
    return _RepositorySearchScreenState();
  }
}

class _RepositorySearchScreenState extends WidgetState<RepositorySearchWm> {
  _RepositorySearchScreenState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: StreamedStateBuilder<bool>(
          streamedState: wm.isSearching,
          builder: (ctx, isSearching) => isSearching
              ? TextField(
                  controller: wm.textToSearchAction.controller,
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                )
              : Text('search repos'),
        ),
        leading: IconButton(
          icon: StreamedStateBuilder<bool>(
            streamedState: wm.isSearching,
            builder: (_, isSearching) =>
                Icon(isSearching ? Icons.clear : Icons.search),
          ),
          onPressed: wm.onAppBarTap,
        ),
        actions: <Widget>[
          FavoritesButton(3),
        ],
      ),
      body: StreamBuilder<ListState>(
        initialData: ListState.content([]),
        stream: wm.repos,
        builder: (ctx, snap) {
          var data = snap.data;
          if ((data?.isLoading ?? false)) {
            return Center(child: CircularProgressIndicator());
          }

          if (snap.hasError || (data?.hasError ?? true)) {
            return Center(
                child: Column(
              children: <Widget>[
                Text('Произошла ошибка'),
                FlatButton(onPressed: wm.refresh, child: Text('Обновить')),
              ],
            ));
          }
          return ListView.builder(
            itemCount: data.data.length,
            itemBuilder: (ctx, i) => Container(
              child: RepoItem(
                data.data[i],
              ),
            ),
          );
        },
      ),
    );
  }
}
