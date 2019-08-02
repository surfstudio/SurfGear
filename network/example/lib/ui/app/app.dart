import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mwwm/mwwm.dart';
import 'package:name_generator/ui/app/app_wm.dart';
import 'package:name_generator/ui/app/di/app.dart';

/// Widget приложения
class App extends StatefulWidget {
  @override
  State createState() => new _AppState();
}

class _AppState extends WidgetState<App, AppWidgetModel, AppComponent> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  Widget buildState(BuildContext context) {
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
    );
  }

  @override
  AppComponent getComponent(BuildContext context) {
    return AppComponent(navigatorKey, scaffoldKey);
  }
}
