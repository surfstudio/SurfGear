// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/data/repository.dart';
import 'package:mwwm_github_client/model/favorites/performers.dart';
import 'package:mwwm_github_client/model/favorites/repository/favorites_repository.dart';
import 'package:mwwm_github_client/ui/widgets/repository/repository_widget_wm.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';

class RepositoryWidget extends CoreMwwmWidget {
  RepositoryWidget({
    @required this.repository,
    Key key,
  })  : assert(repository != null),
        super(
          key: key,
          widgetModelBuilder: (context) => RepositoryWidgetWm(
            context.read<WidgetModelDependencies>(),
            Model([
              ToggleRepositoryFavoriteValuePerformer(
                context.read<FavoritesRepository>(),
              )
            ]),
            repository,
          ),
        );

  final Repository repository;

  @override
  State<StatefulWidget> createState() {
    return _RepositoryWidgetState();
  }
}

class _RepositoryWidgetState extends WidgetState<RepositoryWidgetWm> {
  @override
  Widget build(BuildContext context) {
    return StreamedStateBuilder<Repository>(
        streamedState: wm.repoState,
        builder: (context, repository) {
          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 8),
                  _buildAvatarImage(repository),
                  const SizedBox(height: 8),
                  _buildTitle(repository),
                  const SizedBox(height: 8.0),
                  _buildDescription(repository),
                  const SizedBox(height: 8.0),
                  _buildInformationBlock(repository),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildInformationBlock(Repository repository) => Row(
        children: <Widget>[
          if (repository.language != null)
            ..._buildLanguageInfo(repository.language),
          if (repository.stargazersCount != null)
            ..._buildStarsInfo(repository.stargazersCount),
          if (repository.watchersCount != null)
            ..._buildWatchersInfo(repository.watchersCount),
          const Spacer(),
          _buildFavoriteButton(repository),
        ],
      );

  Widget _buildFavoriteButton(Repository repository) {
    return IconButton(
      icon: StreamedStateBuilder<bool>(
          streamedState: wm.isFavoriteState,
          builder: (context, isFavorite) {
            return Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.redAccent,
            );
          }),
      onPressed: () => wm.favoriteTapAction(
        !repository.isFavorite,
      ),
    );
  }

  Widget _buildDescription(Repository repository) {
    return Text(
      repository.description ?? '',
      style: const TextStyle(color: Colors.black54),
    );
  }

  Widget _buildTitle(Repository repository) {
    return Row(
      children: <Widget>[
        Text(
          '${repository.name}/',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
        Text(
          repository.owner.login ?? '',
          style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildAvatarImage(Repository repository) {
    return Container(
      width: double.infinity,
      height: 200,
      child: repository.owner.avatarUrl != null
          ? Image.network(repository.owner.avatarUrl)
          : SizedBox.fromSize(),
    );
  }

  List<Widget> _buildLanguageInfo(String language) => [
        const Icon(
          Icons.brightness_1,
          size: 16.0,
          color: Colors.blueAccent,
        ),
        const SizedBox(width: 8.0),
        Text(language),
        const SizedBox(width: 24.0),
      ];

  List<Widget> _buildStarsInfo(int starCount) => [
        const Icon(
          Icons.star,
          color: Colors.orangeAccent,
          size: 16.0,
        ),
        const SizedBox(width: 8.0),
        Text('$starCount'),
        const SizedBox(width: 24.0),
      ];

  List<Widget> _buildWatchersInfo(int watchersCount) => [
        const Icon(
          Icons.remove_red_eye,
          size: 16.0,
          color: Colors.green,
        ),
        const SizedBox(width: 8.0),
        Text('$watchersCount'),
      ];
}
