import 'package:flutter/material.dart';
import '../app.dart';

class AppDependencies extends StatelessWidget {
  final App app;

  const AppDependencies({
    Key? key,
    required this.app,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: добавить интеракторы и провайдер
    // final hiveInteractor = HiveInteractor();

    // return MultiProvider(
    //   providers: [
    //     Provider<HiveInteractor>(create: (_) => hiveInteractor),
    //   ],
    //   child: app,
    // );
    return app;
  }
}
