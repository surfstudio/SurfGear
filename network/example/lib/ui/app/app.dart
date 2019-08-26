import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:name_generator/interactor/name_generator/name_generator_interactor.dart';
import 'package:name_generator/ui/screen/name_generator/name_generator_route.dart';
import 'package:name_generator/ui/screen/name_generator/name_generator_screen.dart';

/// Widget приложения
class App extends StatefulWidget {
  final NameGeneratorInteractor interactor;

  App(this.interactor);

  @override
  State createState() => new _AppState();
}

class _AppState extends State<App> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: Scaffold(
        key: scaffoldKey,
        body: Center(
          child: Icon(
            Icons.account_circle,
            size: 200,
            color: Colors.indigo,
          ),
        ),
      ),
      initialRoute: NameGeneratorScreen.routeName,
      onGenerateRoute: (_) => NameGeneratorScreenRoute(widget.interactor),
    );
  }
}
