import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:flutter_template/interactor/debug/debug_screen_interactor.dart';
import 'package:flutter_template/ui/app/app.dart';
import 'package:flutter_template/ui/screen/splash_screen/di/splash_screen_component.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:rxdart/rxdart.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

/// Билдер для WelcomeScreenWidgetModel.
SplashScreenWidgetModel createSplashScreenWidgetModel(BuildContext context) {
  final component = Injector.of<SplashScreenComponent>(context).component;

  return SplashScreenWidgetModel(
    component.wmDependencies,
    component.navigator,
    component.debugScreenInteractor,
  );
}

/// [WidgetModel] для экрана <SplashScreen>
class SplashScreenWidgetModel extends WidgetModel {
  SplashScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this._debugScreenInteractor,
  ) : super(dependencies);

  final widgets.NavigatorState _navigator;
  final DebugScreenInteractor _debugScreenInteractor;

  @override
  void onLoad() {
    super.onLoad();
    _loadApp();
  }

  void _loadApp() {
    subscribeHandleError<bool>(
      initApp(),
      (isAuth) {
        _openScreen(Router.root);
      },
    );
    subscribe<bool>(
      Stream.value(true).delay(const Duration(seconds: 5)),
      (_) => _debugScreenInteractor.showDebugScreenNotification(),
    );
  }

  void _openScreen(String routeName) {
    _navigator.pushReplacementNamed(routeName);
  }

  Stream<bool> initApp() {
    return Stream.value(true).delay(const Duration(seconds: 2));
  }
}
