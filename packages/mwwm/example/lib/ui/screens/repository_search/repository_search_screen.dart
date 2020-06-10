import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/model/repository/response/responses.dart';

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

  Widget _buildBody() => EntityStateBuilder<List<Repo>>(
        streamedState: wm.repositoriesState,
        errorBuilder: (ctx, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text('Произошла ошибка'),
              FlatButton(
                // onPressed: wm.refresh,
                child: Text('Обновить'),
              ),
            ],
          ),
        ),
        loadingBuilder: (ctx, _) => Center(
          child: CircularProgressIndicator(),
        ),
        child: (ctx, snap) {
          var data = snap;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (ctx, i) => Container(
              child: RepositoryWidget(
                repository: data[i],
              ),
            ),
          );
        },
      );

  Widget _buildAppBar() => AppBar(
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
              : Text('search repos');
        },
      );
}
