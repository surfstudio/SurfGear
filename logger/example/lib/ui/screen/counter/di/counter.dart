import 'package:counter/ui/app/di/app.dart';
import 'package:counter/ui/screen/counter/counter_wm.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mwwm/mwwm.dart';

/// Component для экрана счетчика
class CounterComponent implements BaseWidgetModelComponent<CounterWidgetModel> {
  @override
  CounterWidgetModel wm;

  CounterComponent(
    AppComponent parentComponent,
    NavigatorState navigator,
  ) {
    Logger.d('call CounterComponent constructor');
    wm = CounterWidgetModel(
      WidgetModelDependencies(),
      navigator,
      parentComponent.counterInteractor,
    );
  }
}
