import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:flutter_template/interactor/debug/debug_screen_interactor.dart';
import 'package:flutter_template/ui/app/app.dart';
import 'package:flutter_template/ui/screen/splash_screen/di/splash_screen_component.dart';
import 'package:injector/injector.dart';
import 'package:rxdart/rxdart.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

/// Билдер для [WelcomeScreenWidgetModel].
SplashScreenWidgetModel createSplashScreenWidgetModel(BuildContext context) {
  var component = Injector.of<SplashScreenComponent>(context).component;

  return SplashScreenWidgetModel(
    component.wmDependencies,
    component.navigator,
    component.debugScreenInteractor,
  );
}

/// [WidgetModel] для экрана <SplashScreen>
class SplashScreenWidgetModel extends WidgetModel {
  final widgets.NavigatorState _navigator;
  final DebugScreenInteractor _debugScreenInteractor;

  SplashScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this._debugScreenInteractor,
  ) : super(dependencies);

  @override
  void onLoad() {
    super.onLoad();
    _loadApp();
  }

  void _loadApp() async {
    subscribeHandleError(
      initApp(),
      (isAuth) {
        _openScreen(Router.root);
      },
    );
    subscribe(
      Stream.value(true).delay(Duration(seconds: 5)),
      (_) => _debugScreenInteractor.showDebugScreenNotification(),
    );
  }

  void _openScreen(String routeName) {
    _navigator.pushReplacementNamed(routeName);
  }

  Stream<bool> initApp() {
    return Stream.value(true).delay(Duration(seconds: 2));
  }
}
