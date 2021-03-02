import 'package:counter/ui/counter_screen/counter_screen.dart';
import 'package:counter/ui/counter_screen/counter_wm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mwwm/mwwm.dart';

/// Route for [CounterScreen]
class CounterScreenRoute extends MaterialPageRoute {
  CounterScreenRoute()
      : super(
          builder: (context) => CounterScreen(
            widgetModelBuilder: _createCounterWm,
          ),
        );
}

/// Dependencies for [CounterWidgetModel]
WidgetModel _createCounterWm(BuildContext context) {
  return context.read<CounterWidgetModel>();
}
