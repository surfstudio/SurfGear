import 'package:flutter/material.dart';
import 'package:mwwm_github_client/ui/main_screen/main_screen_route.dart';

const _initRouteName = '/';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: _initRouteName,
      onGenerateRoute: (routeSettings) {
        switch (routeSettings.name) {
          case _initRouteName:
            return MainScreenRoute();
          default:
            throw Exception('Unknown route name: ${routeSettings.name}');
        }
      },
    );
  }
}
