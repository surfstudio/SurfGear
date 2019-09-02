import 'package:counter/ui/app/app_wm.dart';
import 'package:counter/ui/app/di/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mwwm/mwwm.dart';

/// Widget приложения
class App extends StatefulWidget {
  @override
  State createState() => new _AppState();
}

class _AppState extends WidgetState<App, AppWidgetModel, AppComponent> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  Widget buildState(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: Scaffold(
        body: Center(
          child: Icon(
            Icons.plus_one,
            size: 200,
            color: Colors.indigo,
          ),
        ),
      ),
    );
  }

  @override
  AppComponent getComponent(BuildContext context) {
    return AppComponent(navigatorKey);
  }
}
