import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:injector/injector.dart';
import 'package:mwwm/mwwm.dart';

import 'di/app.dart';

/// Билдер для [AppWidgetModel].
AppWidgetModel createAppWidgetModel(BuildContext context) {
  var component = Injector.of<AppComponent>(context).component;

  return AppWidgetModel(
    component.wmDependencies,
    component.messageController,
  );
}

/// [WidgetModel] для виджета приложения
class AppWidgetModel extends WidgetModel {

  // ignore: unused_field
  final MessageController _msgController;

  AppWidgetModel(
    WidgetModelDependencies dependencies,
    this._msgController,
  ) : super(dependencies);

}
