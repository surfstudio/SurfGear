import 'dart:async';
import 'package:mwwm/src/scenario/step.dart';

import 'mixins.dart';
import 'package:flutter/material.dart';

typedef void TaskCallback<T>(T data);
typedef void ScenarioErrorCallback(Error e);

class Scenario<T> with CallerFunction {
  @protected
  ScenarioErrorCallback errorCallback;

  @protected
  VoidCallback startCallback;

  Map<StepScenario, TaskCallback> steps  = {};

  Scenario onError(ScenarioErrorCallback callback) {
    errorCallback = callback;
    return this;
  }

  Scenario onStart(VoidCallback callback) {
    startCallback = callback;
    return this;
  }

  Scenario addSep(StepScenario step, [TaskCallback callback]) {
    steps[step] = callback;
    return this;
  }

  @protected
  void runSteps(T data) async {

    for(var step in steps.keys) {
      /// Если true - вызвать колбэк на шаге
      /// false - идти дабше
      /// await - шаг может выполнять свою логику над данными
      /// в таком случае ждем рещультат
      if(await step(data)) steps[step]?.call(data);
    }
  }

  
}

class FutureScenario<T> extends Scenario<T> {
  final Future<T> _future;

  void Function(T data) _dataCallback;

  //Completer<bool> _completer;

  FutureScenario(this._future) {
    _init();
  }

  FutureScenario onData(void Function(T data) callback) {
    _dataCallback = callback;
    return this;
  }

  Future<void> _init() async {
    //_completer = Completer();
    try {
      startCallback?.call();
      final result = await _future;
      callFn<T>(_dataCallback, result);
      runSteps(result);
    } catch(e) {
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