import 'package:counter/ui/screen/counter/counter_screen.dart';
import 'package:flutter/material.dart';

/// Route для экрана счетчика
class CounterScreenRoute extends MaterialPageRoute {
  CounterScreenRoute() : super(builder: (ctx) => CounterScreen());
}
