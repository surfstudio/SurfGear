import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/model/performers.dart';
import 'package:mwwm_github_client/model/repository/favorites_repository.dart';
import 'package:provider/provider.dart';
import 'package:mwwm_github_client/model/repository/response/reponses.dart';
import 'package:mwwm_github_client/ui/common/repo_item/repo_item_wm.dart';
import 'package:relation/relation.dart';

//todo добавить сохранение в бд
class RepoItemUiModel {
  final Repo repository;

  RepoItemUiModel({
    this.repository,
  });
}

class RepoItem extends CoreMwwmWidget {
  final RepoItemUiModel item;
  RepoItem(this.item, {WidgetModelBuilder wmBuilder})
      : super(
            widgetModelBuilder: wmBuilder ??
                (ctx) => RepoItemWm(
                      ctx.read<WidgetModelDependencies>(),
                      Model([AddToFavoritePerformer(ctx.read<FavoritesRepository>())]),
                      item.repository,
                    ));

  @override
  State<StatefulWidget> createState() {
    return _RepoItemState();
  }
}

class _RepoItemState extends WidgetState<RepoItemWm> {
  @override
  Widget build(BuildContext context) {
    return StreamedStateBuilder<Repo>(
        streamedState: wm.repoState,
        builder: (context, repository) {
          return Card(
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 300,
                  child: Image.network(
                    repository.owner.avatarUrl,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            '${repository.name}/',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            repository.owner.login ?? '',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        repository.description ?? '',
                        style: TextStyle(color: Colors.black54),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.brightness_1,
                            size: 16.0,
                            color: Colors.blueAccent,
                          ),
                          SizedBox(width: 8.0),
                          Text('${repository.language}'),
                          SizedBox(
                            width: 24.0,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.orangeAccent,
                            size: 16.0,
                          ),
                          SizedBox(width: 8.0),
                          Text('${repository.stargazersCount}'),
                          SizedBox(
                            width: 24.0,
                          ),
                          Icon(
                            Icons.remove_red_eye,
                            size: 16.0,
                            color: Colors.green,
                          ),
                          SizedBox(width: 8.0),
                          Text('${repository.watchersCount}'),
                          Spacer(),
                          IconButton(
                            icon: StreamedStateBuilder<bool>(
                              streamedState: wm.isFavorite,
                              builder: (context, isFavorite) {
                                return Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.redAccent,
                                );
                              }
                            ),
                            onPressed:() => wm.addToFavorite(repository.isFavorite),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
