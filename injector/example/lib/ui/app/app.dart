import 'package:counter/ui/app/app_wm.dart';
import 'package:counter/ui/app/di/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:injector/injector.dart';

/// Widget приложения
class App extends StatefulWidget {
  @override
  State createState() => new _AppState();
}

class _AppState extends State<App> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  AppWidgetModel wm;

  @override
  Widget build(BuildContext context) {
    return Injector<AppComponent>(
      component: AppComponent(navigatorKey),
      builder: (context) {
        wm = Injector.of<AppComponent>(context).component.wm;
        return _buildState(context);
      },
    );
  }

  Widget _buildState(BuildContext context) {
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
  void dispose() {
    wm.dispose();
    super.dispose();
  }
}
