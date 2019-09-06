import 'package:counter/ui/app/app_wm.dart';
import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';

/// Component для приложения
class AppComponent implements BaseWidgetModelComponent<AppWidgetModel> {
  AppWidgetModel wm;

  AppComponent(Key navigatorKey) {
    wm = AppWidgetModel(
      WidgetModelDependencies(),
      navigatorKey,
    );
  }
}
