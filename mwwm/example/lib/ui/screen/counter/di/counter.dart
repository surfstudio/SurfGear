import 'package:counter/ui/screen/counter/counter_wm.dart';
import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';

/// Component для экрана счетчика
class CounterComponent implements BaseWidgetModelComponent<CounterWidgetModel> {
  @override
  CounterWidgetModel wm;

  CounterComponent(
    NavigatorState navigator,
  ) {
    wm = CounterWidgetModel(
      WidgetModelDependencies(),
      navigator,
    );
  }
}
