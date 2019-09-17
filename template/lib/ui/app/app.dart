import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/config/env/env.dart';
import 'package:flutter_template/domain/debug_options.dart';
import 'package:flutter_template/ui/app/app_wm.dart';
import 'package:flutter_template/ui/app/di/app.dart';
import 'package:flutter_template/ui/res/assets.dart';
import 'package:flutter_template/ui/res/colors.dart';
import 'package:flutter_template/ui/res/styles.dart';
import 'package:flutter_template/ui/screen/phone_input/phone_route.dart';
import 'package:mwwm/mwwm.dart';
import 'package:flutter_template/util/error_wiget.dart' as error_widget;
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
    Environment.instance().removeListener(_setStateOnChangeConfig);
    super.dispose();
  }

  Widget buildState(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      builder: (BuildContext context, Widget widget) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return error_widget.ErrorWidget(
            context: context,
            error: errorDetails,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            errorMessage: "test",
          );
        };
        return widget;
      },
      navigatorObservers: [
        PushObserver(),
      ],
      theme: themeData,
      showPerformanceOverlay: getDebugConfig().showPerformanceOverlay,
      debugShowMaterialGrid: getDebugConfig().debugShowMaterialGrid,
      checkerboardRasterCacheImages:
          getDebugConfig().checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: getDebugConfig().checkerboardOffscreenLayers,
      showSemanticsDebugger: getDebugConfig().showSemanticsDebugger,
      debugShowCheckedModeBanner: getDebugConfig().debugShowCheckedModeBanner,
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

  DebugOptions getDebugConfig() => Environment.instance().config.debugOptions;
}
