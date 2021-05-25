import 'package:counter/ui/counter_screen/counter_screen.dart';
import 'package:counter/ui/counter_screen/counter_wm.dart';
import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';

/// Route for [CounterScreen]
class CounterScreenRoute<T> extends MaterialPageRoute<T> {
  CounterScreenRoute()
      : super(
          builder: (context) => const CounterScreen(
            widgetModelBuilder: _createCounterWm,
          ),
        );
}

/// Dependencies for [CounterWidgetModel]
WidgetModel _createCounterWm(BuildContext context) {
  return context.read<CounterWidgetModel>();
}
