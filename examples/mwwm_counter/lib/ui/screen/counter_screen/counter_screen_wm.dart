import 'package:flutter/cupertino.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';

class CounterScreenWidgetModel extends WidgetModel {
  // * инициализация каунтера как стрима int-ов с начальным значеним 0
  final counter = StreamedState<int>(0);

  // * конструктор WidgeModel (создается в IDE через Create constructor co call super)
  // * в данном случае ничего не принимает
  CounterScreenWidgetModel(WidgetModelDependencies baseDependencies)
      : super(baseDependencies);

  // * функция - инкремент каунтера
  void incrementCounter() {
    counter.accept(counter.value + 1);
  }
}

// * функция - создание WidgetModel. Используется в CounterScreen
CounterScreenWidgetModel createCounterScreenWidgetModel(
  BuildContext context,
) {
  return CounterScreenWidgetModel(
    const WidgetModelDependencies(),
  );
}
