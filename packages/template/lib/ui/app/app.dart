import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/config/env/env.dart';
import 'package:flutter_template/domain/debug_options.dart';
import 'package:flutter_template/ui/app/app_wm.dart';
import 'package:flutter_template/ui/app/di/app.dart';
import 'package:flutter_template/ui/res/styles.dart';
import 'package:flutter_template/ui/screen/splash_screen/splash_route.dart';
import 'package:flutter_template/ui/screen/welcome_screen/welcome_route.dart';
import 'package:flutter_template/util/error_wiget.dart' as error_widget;
import 'package:injector/injector.dart';
import 'package:mwwm/mwwm.dart';
import 'package:push/push.dart';

// todo оставить здесь только необходимые маршруты
class Router {
  static const String root = "/";
  static const String splashScreen = "/splash";

  static final Map<String, Route Function(dynamic data)> routes = {
    Router.root: (data) => WelcomeScreenRoute(),
    Router.splashScreen: (data) => SplashScreenRoute(),
  };
}

/// Виджет приложения
class App extends MwwmWidget<AppComponent> {
  App([
    WidgetModelBuilder widgetModelBuilder = createAppWidgetModel,
  ]) : super(
    dependenciesBuilder: (context) => AppComponent(context),
    widgetStateBuilder: () => _AppState(),
    widgetModelBuilder: widgetModelBuilder,
  );
}

class _AppState extends WidgetState<AppWidgetModel> {
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

  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Injector.of<AppComponent>(context).component.navigator,
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
      initialRoute: Router.splashScreen,
      onGenerateRoute: (RouteSettings rs) =>
          Router.routes[rs.name](rs.arguments),
    );
  }

  void _setStateOnChangeConfig() {
    setState(() {});
  }

  DebugOptions getDebugConfig() => Environment.instance().config.debugOptions;
}
