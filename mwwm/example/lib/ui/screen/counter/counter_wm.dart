import 'package:flutter/material.dart' show NavigatorState;
import 'package:mwwm/mwwm.dart';

/// WidgetModel для экрана счетчика
class CounterWidgetModel extends WidgetModel {
  final NavigatorState navigator;

  Action incrementAction = Action();

  StreamedState<int> counterState = StreamedState(0);

  CounterWidgetModel(
    WidgetModelDependencies dependencies,
    this.navigator,
  ) : super(dependencies);

  @override
  void onLoad() {
    _listenToActions();
    super.onLoad();
  }

  void _listenToActions() {
    bind(
      incrementAction,
      (_) => counterState.accept(counterState.value + 1),
    );
  }
}
