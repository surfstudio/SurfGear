import 'package:flutter/widgets.dart';
import 'package:flutter_template/ui/app/app.dart';
import 'package:mwwm/mwwm.dart';


class AppWidgetModel extends WidgetModel {
  final GlobalKey<NavigatorState> _navigator;
  final MessageController _msgController;

  AppWidgetModel(
    WidgetModelDependencies dependencies,
    this._msgController,
    this._navigator,
  ) : super(dependencies);

  @override
  void onLoad() {
    _loadApp();
  }

  void _loadApp() async {
    subscribeHandleError(
      initApp().then((_) => Future.delayed(Duration(seconds: 2))).asStream(),
      (isAuth) {
        _openScreen(Router.ROOT);
      },
    );
  }

  void _openScreen(String routeName) {
    _navigator.currentState.pushReplacementNamed(routeName);
  }

  Future<void> initApp() {
    return Future.delayed(Duration(seconds: 2));
  }
}
