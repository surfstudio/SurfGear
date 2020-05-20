import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/model/service/github_service.dart';
import 'package:mwwm_github_client/model/service/response/reponses.dart';
import 'package:mwwm_github_client/ui/common/repo_item.dart';
import 'package:mwwm_github_client/ui/repos/widgets/favorites_button.dart';
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

class _RepositorySearchScreenState extends WidgetState<RepositorySearchWm> {
  TextEditingController _controller;

  bool isSearching = false;

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
        centerTitle: true,
        title: isSearching
            ? TextField(
                controller: _controller,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              )
            : Text('search repos'),
        leading: IconButton(
          icon: Icon(isSearching ? Icons.clear : Icons.search),
          onPressed: () {
            setState(() {
              if (_controller.text.isNotEmpty) {
                _controller.text = '';
              } else {
                isSearching = !isSearching;
              }
            });
          },
        ),
        actions: <Widget>[
          FavoritesButton(3),
        ],
      ),
      body: FutureBuilder<List<Repo>>(
        initialData: [],
        future: context.watch<GithubRepository>().getRepos(_controller.text),
        builder: (ctx, snap) {
          return ListView.builder(
            itemCount: 10,
            itemBuilder: (ctx, i) => Container(
              child: RepoItem(
                getMockModel(),
              ),
            ),
          );
        },
      ),
    );
  }

  RepoItemUiModel getMockModel() => RepoItemUiModel(
        repostory: Repo(
          name: 'repo_name',
          owner: Owner(
            login: 'owner_login',
            avatarUrl:
                'https://lh3.googleusercontent.com/proxy/OGL6XVA38k_lEs0Ft-7JWjusSRFJB01UGWTaY0qnHE_kD_K9gDWVyRZ_Ua2dJ_O5VbZ5y5ovpfoRlUJUBRVcRkPxHWCAWQSh_jf6HyE',
          ),
          description:
              'descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptionfdzfsdfdsafsdafsdafsd'
              'descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptionfdzfsdfdsafsdafsdafsd'
              'descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptionfdzfsdfdsafsdafsdafsd'
              'descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptionfdzfsdfdsafsdafsdafsd'
              'descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptionfdzfsdfdsafsdafsdafsd',
          language: 'language_name',
          stargazersCount: 50,
          watchersCount: 50,
        ),
        isFavorite: true,
      );
}
