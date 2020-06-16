import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/model/favorites_repository/database/database.dart';
import 'package:mwwm_github_client/model/favorites_repository/repository/favorites_repository.dart';
import 'package:mwwm_github_client/model/github_repository/repository/github_repository.dart';
import 'package:mwwm_github_client/ui/app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    Provider(
      create: (_) => Database(),
      child: MultiProvider(
        providers: [
          Provider(
            create: (_) => WidgetModelDependencies(
              errorHandler: DefaultErrorHandler(),
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

/// Log errors
class DefaultErrorHandler implements ErrorHandler {
  @override
  void handleError(Object e) {
    //here you can place logic for error handling

    debugPrint(e.toString());
  }
}
