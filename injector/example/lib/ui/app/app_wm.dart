import 'package:counter/ui/screen/counter/counter_route.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

/// WidgetModel приложения
class AppWidgetModel {
  final GlobalKey<NavigatorState> _navigator;

  AppWidgetModel(
    this._navigator,
  ) {
    _loadApp();
  }

  void _loadApp() async {
    initApp().listen(
      (isAuth) {
        _openScreen(CounterScreenRoute());
      },
    );
  }

  dispose() {}

  Observable<bool> initApp() {
    /// имитация задержки на инициализацию приложения
    return Observable.just(true).delay(Duration(seconds: 2));
  }

  void _openScreen(PageRoute route) {
    _navigator.currentState.pushReplacement(route);
  }
}
