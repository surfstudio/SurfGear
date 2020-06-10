import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/data/repository.dart';

import 'package:mwwm_github_client/ui/screens/repository_search/repository_search_wm.dart';
import 'package:mwwm_github_client/ui/widgets/repository/repository_widget.dart';
import 'package:relation/relation.dart';

/// Search repository screen
class RepositorySearchScreen extends CoreMwwmWidget {
  RepositorySearchScreen({
    @required WidgetModelBuilder widgetModelBuilder,
  })  : assert(widgetModelBuilder != null),
        super(widgetModelBuilder: widgetModelBuilder);

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
            itemBuilder: (ctx, i) => RepositoryWidget(
              repository: repositories[i],
            ),
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
