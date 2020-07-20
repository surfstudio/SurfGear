import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/config/config.dart';
import 'package:flutter_template/config/env/env.dart';
import 'package:flutter_template/domain/debug_options.dart';
import 'package:flutter_template/ui/app/app_wm.dart';
import 'package:flutter_template/ui/app/di/app.dart';
import 'package:flutter_template/ui/res/styles.dart';
import 'package:flutter_template/ui/screen/splash_screen/splash_route.dart';
import 'package:flutter_template/ui/screen/welcome_screen/welcome_route.dart';
import 'package:flutter_template/util/error_widget.dart' as error_widget;
import 'package:injector/injector.dart';
import 'package:push_notification/push_notification.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

// todo оставить здесь только необходимые маршруты
class Router {
  static const String root = '/';
  static const String splashScreen = '/splash';

  // ignore: avoid_annotating_with_dynamic
  static final Map<String, Route Function(dynamic)> routes = {
    Router.root: (data) => WelcomeScreenRoute(),
    Router.splashScreen: (data) => SplashScreenRoute(),
  };
}

/// Виджет приложения
class App extends MwwmWidget<AppComponent> {
  App({
    Key key,
    WidgetModelBuilder widgetModelBuilder = createAppWidgetModel,
  }) : super(
          key: key,
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Injector.of<AppComponent>(context).component.navigator,
      builder: (context, widget) {
        ErrorWidget.builder = (flutterErrorDetails) {
          return error_widget.ErrorWidget(
            context: context,
            error: flutterErrorDetails,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            errorMessage: 'test',
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
      onGenerateRoute: (routeSettings) =>
          Router.routes[routeSettings.name](routeSettings.arguments),
    );
  }

  void _setStateOnChangeConfig() {
    setState(() {});
  }

  DebugOptions getDebugConfig() {
    return Environment<Config>.instance().config.debugOptions;
  }
}
