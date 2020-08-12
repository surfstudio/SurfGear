import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:mwwm/mwwm.dart';

import 'di/app.dart';

/// Билдер для [AppWidgetModel].
AppWidgetModel createAppWidgetModel(BuildContext context) {
  final component = Injector.of<AppComponent>(context).component;

  return AppWidgetModel(
    component.wmDependencies,
    component.messageController,
  );
}

/// [WidgetModel] для виджета приложения
class AppWidgetModel extends WidgetModel {
  AppWidgetModel(
    WidgetModelDependencies dependencies,
    this._msgController,
  ) : super(dependencies);

  // ignore: unused_field
  final MessageController _msgController;
}
