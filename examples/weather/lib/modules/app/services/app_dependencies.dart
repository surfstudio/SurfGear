import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/modules/app/services/app_storage_interactor.dart';
import 'package:weather/modules/app/services/app_storage_repository.dart';
import '../app.dart';

class AppDependencies extends StatelessWidget {
  final App app;

  const AppDependencies({
    Key? key,
    required this.app,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appStorageRepository = AppStorageRepository();
    final appStorageInteractor = AppStorageInteractor(appStorageRepository);

    return MultiProvider(
      providers: [
        Provider<AppStorageInteractor>(create: (_) => appStorageInteractor),
      ],
      child: app,
    );
  }
}
