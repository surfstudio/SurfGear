import 'dart:async';

import 'package:counter/data/counter/repository/counter_repository.dart';
import 'package:mwwm/mwwm.dart';
import 'package:rxdart/rxdart.dart';

/// Counter screen's widget model
class CounterWidgetModel extends WidgetModel {
  CounterWidgetModel(
    WidgetModelDependencies baseDependencies,
    this._counterRepository,
  ) : super(baseDependencies);

  final CounterRepository _counterRepository;

  final counterState = BehaviorSubject<int>();

  @override
  void onLoad() {
    super.onLoad();
    _initCounter();
  }

  Future<void> _initCounter() async {
    counterState.add(await _counterRepository.getCounter());
  }

  void increment() {
    counterState.add(counterState.value + 1);
    _counterRepository.changeCounter(counterState.value);
  }

  @override
  void dispose() {
    super.dispose();
    counterState.close();
  }
}
