import 'package:flutter/material.dart';
import 'package:mwwm_example/features/app/presentation/router/app_router.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey:
          Provider.of<GlobalKey<NavigatorState>>(context, listen: false),
      initialRoute: AppRouter.loginScreen,
      onGenerateRoute: (routeSettings) =>
          AppRouter.routes[routeSettings.name]!(routeSettings.arguments),
      onGenerateInitialRoutes: (name) {
        return [
          AppRouter.routes[name]!(null),
        ];
      },
    );
  }
}
