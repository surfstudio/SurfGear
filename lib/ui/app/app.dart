import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/ui/app/di/app.dart';
import 'package:flutter_template/ui/app/app_wm.dart';
import 'package:flutter_template/ui/base/widget_state.dart';
import 'package:flutter_template/ui/res/assets.dart';
import 'package:flutter_template/ui/res/colors.dart';
import 'package:flutter_template/ui/res/styles.dart';
import 'package:flutter_template/ui/screen/phone_input/phone_route.dart';

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

  Widget buildState(BuildContext context) {
    _initPushNotification(context);
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: themeData,
      home: Scaffold(
        key: scaffoldKey,
        body: Container(
            decoration: BoxDecoration(
          color: backgroundColor,
          image: DecorationImage(image: AssetImage(logoSmall)),
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

  void _initPushNotification(BuildContext context) {
//    PushManager pushManager =
//        Injector.of<AppComponent>(context).get(PushManager);
//    NotificationController notificationController =
//        Injector.of<AppComponent>(context).get(NotificationController);
//
//    pushManager.initNotification(notificationController.show);
  }
}
