import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/model/service/github_service.dart';
import 'package:mwwm_github_client/model/service/response/reponses.dart';
import 'package:mwwm_github_client/ui/common/error_handler.dart';
import 'package:mwwm_github_client/ui/repos/repository_search_wm.dart';
import 'package:provider/provider.dart';

class RepositorySearchScreen extends CoreMwwmWidget {
  RepositorySearchScreen()
      : super(
          widgetStateBuilder: () => _RepositorySearchScreenState(),
          widgetModelBuilder: (ctx) => RepositorySearchWm(
            ctx.read<WidgetModelDependencies>(),
          ),
        );
}

//todo: add actions to read text and search 
class _RepositorySearchScreenState extends WidgetState<RepositorySearchWm> {
  TextEditingController _controller;

  _RepositorySearchScreenState() {
    _controller = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.search),
        title: TextField(
          controller: _controller,
        ),
      ),
      body: FutureBuilder<List<Items>>(
        initialData: [],
        future: context.watch<GithubRepository>().getRepos(_controller.text),
        builder: (ctx, snap) {
          return ListView.builder(
            itemCount: snap.data.length,
            itemBuilder: (ctx, i) => Container(
              child: Text("${snap.data[i].name}"),
            ),
          );
        },
      ),
    );
  }
}
