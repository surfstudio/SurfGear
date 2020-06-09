import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/model/repository/github_repository.dart';
import 'package:mwwm_github_client/model/repository/response/reponses.dart';
import 'package:mwwm_github_client/ui/common/repo_item/repo_item.dart';
import 'package:mwwm_github_client/ui/favorites/favorites_wm.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends CoreMwwmWidget {
  FavoritesScreen()
      : super(
          widgetModelBuilder: (ctx) => FavoritesWm(
            ctx.read<WidgetModelDependencies>(),
          ),
        );

  @override
  State<StatefulWidget> createState() {
    return _FavoritesScreenState();
  }
}

//todo: add actions to read text and search
class _FavoritesScreenState extends WidgetState<FavoritesWm> {
  TextEditingController _controller;

  _FavoritesScreenState() {
    _controller = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('favorites'),
      ),
      body: FutureBuilder<List<Repo>>(
        initialData: [],
        future: context.watch<GithubRepository>().getRepos(_controller.text),
        builder: (ctx, snap) {
          return ListView.builder(
            itemCount: 1,
            itemBuilder: (ctx, i) => Container(
              child: RepoItem(
                RepoItemUiModel(
                  repository: Repo(
                    name: 'repo_name',
                    owner: Owner(
                        login: 'owner_login',
                        avatarUrl:
                            'https://lh3.googleusercontent.com/proxy/OGL6XVA38k_lEs0Ft-7JWjusSRFJB01UGWTaY0qnHE_kD_K9gDWVyRZ_Ua2dJ_O5VbZ5y5ovpfoRlUJUBRVcRkPxHWCAWQSh_jf6HyE'),
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
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
