import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/data/repository.dart';
import 'package:mwwm_github_client/model/favorites_repository/performers.dart';
import 'package:mwwm_github_client/model/favorites_repository/repository/favorites_repository.dart';
import 'package:mwwm_github_client/ui/main_screen/pages/favorites/favorites_wm.dart';
import 'package:mwwm_github_client/ui/widgets/repository/repository_widget.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';

class FavoritesPage extends CoreMwwmWidget {
  FavoritesPage()
      : super(
          widgetModelBuilder: (context) => FavoritesWm(
            context.read<WidgetModelDependencies>(),
            Model([
              GetFavoriteRepositoriesPerformer(
                context.read<FavoritesRepository>(),
              ),
            ]),
          ),
        );

  @override
  State<StatefulWidget> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends WidgetState<FavoritesWm> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      );

  PreferredSizeWidget _buildAppBar() => AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
      );

  Widget _buildBody() {
    return EntityStateBuilder<List<Repository>>(
      streamedState: wm.favoritesState,
      child: (context, favorites) {
        if (favorites.isEmpty) {
          return _buildEmptyState();
        } else {
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final Repository repo = favorites[index];
              return RepositoryWidget(
                key: ValueKey(repo.id),
                repository: repo,
              );
            },
          );
        }
      },
      loadingBuilder: _buildLoadingState,
      errorBuilder: _buildError,
    );
  }

  Widget _buildEmptyState() {
    return const Center(child: Text('Empty'));
  }

  Widget _buildLoadingState(BuildContext context, _) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError(BuildContext context, _) {
    return const Center(child: Text('Error'));
  }
}
