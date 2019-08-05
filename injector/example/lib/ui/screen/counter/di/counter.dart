import 'package:counter/ui/app/di/app.dart';
import 'package:counter/ui/screen/counter/counter_wm.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

/// Component для экрана счетчика
class CounterComponent implements Component {
  CounterWidgetModel wm;

  CounterComponent(
    AppComponent parentComponent,
    NavigatorState navigator,
  ) {
    wm = CounterWidgetModel(
      navigator,
      parentComponent.counterInteractor,
    );
  }
}
