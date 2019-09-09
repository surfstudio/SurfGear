/// Copyright (c) 2019-present,  SurfStudio LLC
/// 
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
/// 
///     http://www.apache.org/licenses/LICENSE-2.0
/// 
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/ui/app/app_wm.dart';
import 'package:flutter_template/ui/app/di/app.dart';
import 'package:flutter_template/ui/res/assets.dart';
import 'package:flutter_template/ui/res/colors.dart';
import 'package:flutter_template/ui/res/styles.dart';
import 'package:flutter_template/ui/screen/phone_input/phone_route.dart';
import 'package:mwwm/mwwm.dart';

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

  void _initPushNotification(BuildContext context) {
//    PushManager pushManager =
//        Injector.of<AppComponent>(context).get(PushManager);
//    NotificationController notificationController =
//        Injector.of<AppComponent>(context).get(NotificationController);
//
//    pushManager.initNotification(notificationController.show);
  }
}
