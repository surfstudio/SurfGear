import 'dart:async';
import 'package:mwwm/src/scenario/step.dart';

import 'mixins.dart';
import 'package:flutter/material.dart';

typedef void TaskCallback<T>(T data);
typedef void ScenarioErrorCallback(Error e);

/// Сценарий выболнения
/// В соответствии с шагом вызывает колбэк
class Scenario<T> with CallerFunction {

  /// Колбэк ошибки
  @protected
  ScenarioErrorCallback errorCallback;

  /// Колбэк начала выполнения сценария
  @protected
  VoidCallback startCallback;

  /// Шаги сценария
  Map<StepScenario, TaskCallback> steps  = {};

  /// Установка колбэка ошибки
  Scenario onError(ScenarioErrorCallback callback) {
    errorCallback = callback;
    return this;
  }

  /// Установка начала выполнения сценария
  Scenario onStart(VoidCallback callback) {
    startCallback = callback;
    return this;
  }

  /// Добаить шаг
  Scenario addSep(StepScenario step, [TaskCallback callback]) {
    steps[step] = callback;
    return this;
  }

  /// Запуск шагов
  @protected
  void runSteps(T data) async {

    for(var step in steps.keys) {
      /// Если true - вызвать колбэк на шаге
      /// false - не вызывать
      /// await - ожидание выполнения логики шага
      if(await step(data)) steps[step]?.call(data);
    }
  }

  
}

/// Сценарий основанный на Future
class FutureScenario<T> extends Scenario<T> {
  final Future<T> _future;

  /// Колбэк данных
  void Function(T data) _dataCallback;

  FutureScenario(this._future) {
    _init();
  }

  /// Установка колбэка получения данных
  FutureScenario onData(void Function(T data) callback) {
    _dataCallback = callback;
    return this;
  }

  Future<void> _init() async {
    try {
      /// Начало выполнения сценария
      startCallback?.call();
      /// Ждем Future
      final result = await _future;
      /// Стартовый колбэк
      callFn<T>(_dataCallback, result);
      /// Запуск шагов
      runSteps(result);
    } catch(e) {
      /// Если где-то обвалилось - падает сюда
      callFn<Error>(errorCallback, e);
    }
  }
}

/// В сценарий скармливается EntityScenario - нам остается реагировать на колбэки
// class EntityScenario<T> extends Scenario {
//   VoidCallback _loadCallback;


//   final EntityStreamedState _streamedState;
  
//   EntityScenario(this._streamedState);


//   EntityScenario onLoad(VoidCallback callback) {
//     _loadCallback = callback;
//     return this;
//   }

// }