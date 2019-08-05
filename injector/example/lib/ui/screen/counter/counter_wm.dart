import 'package:counter/interactor/counter/counter_interactor.dart';
import 'package:flutter/material.dart' show NavigatorState;
import 'package:rxdart/rxdart.dart';

/// WidgetModel для экрана счетчика
class CounterWidgetModel {
  final NavigatorState navigator;

  final CounterInteractor _counterInteractor;

  BehaviorSubject<bool> incrementAction = BehaviorSubject();
  BehaviorSubject<int> counterState = BehaviorSubject();

  CounterWidgetModel(
    this.navigator,
    this._counterInteractor,
  ) {
    _listenToActions();
    _listenToStreams();
  }

  dispose() {
    incrementAction.close();
    counterState.close();
  }

  void _listenToStreams() {
    _counterInteractor.counterObservable.listen((counter) {
      counterState.add(counter.count);
    });
  }

  void _listenToActions() {
    incrementAction.listen((_) {
      _counterInteractor.incrementCounter();
    });
  }
}
