import 'package:flutter/widgets.dart';
import 'package:injector/injector.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm/mwwm.dart' as m;
import 'package:rxdart/rxdart.dart';

import 'di/main_screen_component.dart';

MainScreenWidgetModel createMainScreenWidgetModel(BuildContext context) {
  var component = Injector.of<MainScreenComponent>(context).component;

  return MainScreenWidgetModel(
    component.widgetModelDependencies,
    component.navigator,
  );
}

/// [WidgetModel] для экрана MainScreen
class MainScreenWidgetModel extends WidgetModel {
  final NavigatorState navigator;

  final m.Action nextAction = m.Action();

  MainScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this.navigator,
  ) : super(dependencies);

  @override
  void onLoad() {
    _listenToActions();

    super.onLoad();
  }

  void _listenToActions() {
    bind(nextAction, (_) {
      subscribeHandleError(
          Observable<void>.error(Exception("Failed Increment")), (_) {});
    });
  }
}
