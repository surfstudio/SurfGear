import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/model/database/database.dart';
import 'package:mwwm_github_client/model/repository/favorites_repository.dart';
import 'package:mwwm_github_client/model/repository/github_repository.dart';
import 'package:mwwm_github_client/ui/app.dart';
import 'package:mwwm_github_client/ui/common/error_handler.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    Provider(
      create: (_) => Database(),
      child: MultiProvider(
        providers: [
          Provider(
            create: (_) => WidgetModelDependencies(
              errorHandler: DefaultErrorHadler(),
            ),
          ),
          Provider(
            create: (_) => GithubRepository(),
          ),
          Provider(
            create: (context) => FavoritesRepository(Database()),
          ),
        ],
        child: App(),
      ),
    ),
  );
}
