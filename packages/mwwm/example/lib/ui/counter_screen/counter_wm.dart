import 'dart:async';

import 'package:counter/data/counter/repository/counter_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:mwwm/mwwm.dart';

/// Counter screen's widget model
// ignore: prefer_mixin
class CounterWidgetModel extends WidgetModel with ChangeNotifier {
  final CounterRepository _counterRepository;
  int counter = 0;

  CounterWidgetModel(
    WidgetModelDependencies baseDependencies,
    this._counterRepository,
  ) : super(baseDependencies);

  @override
  void onLoad() {
    super.onLoad();
    _initCounter();
  }

  void increment() {
    counter++;
    _counterRepository.changeCounter(counter);
    notifyListeners();
  }

  Future<void> _initCounter() async {
    counter = await _counterRepository.getCounter();
    notifyListeners();
  }
}
