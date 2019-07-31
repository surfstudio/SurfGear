import 'package:counter/ui/screen/counter/counter_route.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:mwwm/mwwm.dart';
import 'package:rxdart/rxdart.dart';

/// WidgetModel приложения
class AppWidgetModel extends WidgetModel {
  final GlobalKey<NavigatorState> _navigator;

  AppWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
  ) : super(dependencies);

  @override
  void onLoad() {
    Logger.d('call App_WM.onLoad()');
    _loadApp();
    super.onLoad();
  }

  void _loadApp() async {
    subscribeHandleError(
      initApp(),
      (isAuth) {
        _openScreen(CounterScreenRoute());
      },
    );
  }

  Observable<bool> initApp() {
    /// имитация задержки на инициализацию приложения
    return Observable.just(true).delay(Duration(seconds: 2));
  }

  void _openScreen(PageRoute route) {
    Logger.d('call App_WM.openScreen(${route.toString()})');
    _navigator.currentState.pushReplacement(route);
  }
}
