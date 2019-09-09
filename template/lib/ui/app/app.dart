import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/config/env/env.dart';
import 'package:flutter_template/ui/app/app_wm.dart';
import 'package:flutter_template/ui/app/di/app.dart';
import 'package:flutter_template/ui/res/assets.dart';
import 'package:flutter_template/ui/res/colors.dart';
import 'package:flutter_template/ui/res/styles.dart';
import 'package:flutter_template/ui/screen/phone_input/phone_route.dart';
import 'package:mwwm/mwwm.dart';
import 'package:push/push.dart';

// todo оставить здесь только необходимые маршруты
class Router {
  static const String ROOT = "/";

  static final Map<String, Route Function(dynamic data)> routes = {
    Router.ROOT: (data) => PhoneInputRoute(),
  };
}

/// Виджет приложения
class App extends StatefulWidget {
  @override
  State createState() => _AppState();
}

class _AppState extends WidgetState<App, AppWidgetModel, AppComponent> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    Environment.instance().addListener(_setStateOnChangeConfig);
  }

  @override
  void dispose() {
    super.dispose();
    Environment.instance().removeListener(_setStateOnChangeConfig);
  }

  Widget buildState(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      navigatorObservers: [
        PushObserver(),
      ],
      theme: themeData,
      showPerformanceOverlay:
          Environment.instance().config.debugOptions.showPerformanceOverlay,
      home: Scaffold(
        key: scaffoldKey,
        body: Container(
            decoration: BoxDecoration(
          color: backgroundColor,
          image: DecorationImage(
              image: AssetImage(icAlert)), //todo лого для сплеша
        )),
      ),
      onGenerateRoute: (RouteSettings rs) =>
          Router.routes[rs.name](rs.arguments),
    );
  }

  @override
  AppComponent getComponent(BuildContext context) {
    return AppComponent(navigatorKey, scaffoldKey);
  }

  void _setStateOnChangeConfig() {
    setState(() {});
  }
}
