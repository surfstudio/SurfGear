import 'package:counter/interactor/counter/counter_interactor.dart';
import 'package:flutter/material.dart' show NavigatorState;
import 'package:mwwm/mwwm.dart';

/// WidgetModel для экрана счетчика
class CounterWidgetModel extends WidgetModel {
  final NavigatorState navigator;

  final CounterInteractor _counterInteractor;

  final Action incrementAction = Action();
  final StreamedState<int> counterState = StreamedState(0);

  CounterWidgetModel(
    WidgetModelDependencies dependencies,
    this.navigator,
    this._counterInteractor,
  ) : super(dependencies);

  @override
  void onLoad() {
    _listenToActions();
    _listenToStreams();
    super.onLoad();
  }

  void _listenToStreams() {
    subscribe(
      _counterInteractor.counterObservable,
      (c) => counterState.accept(c.count),
    );
  }

  void _listenToActions() {
    bind(
      incrementAction,
      (_) => _counterInteractor.incrementCounter(),
    );
  }
}
