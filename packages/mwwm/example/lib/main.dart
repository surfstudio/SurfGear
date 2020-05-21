import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/model/database/database.dart';
import 'package:mwwm_github_client/model/service/favorites_repository.dart';
import 'package:mwwm_github_client/model/service/github_repository.dart';
import 'package:mwwm_github_client/ui/app.dart';
import 'package:mwwm_github_client/ui/common/error_handler.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
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
          create: (_) => Database(),
          child: Provider(
            create: (context) => FavoritesRepository(context.read<Database>()),
          ),
        )
      ],
      child: App(),
    ),
  );
}
