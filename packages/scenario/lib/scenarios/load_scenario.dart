import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:scenario/result.dart';
import 'package:scenario/scenarios/base_scenario.dart';
import 'package:scenario/scenarios/scenario.dart';
import 'package:scenario/steps/step_scenario.dart';
import 'package:scenario/types.dart';

/// Сценарий загрузки данных
class LoadScenario<T> extends BaseScenario {
  VoidCallback onLoad;
  LoadScenarioDataCallback<T> onData;
  LoadScenarioDataCallback<T> ifHasData;
  VoidCallback ifNoData;
  ErrorScenarioCallback onError;

  Scenario<T> _scenario;

  LoadScenario({
    @required Future<T> future,
    this.onLoad,
    this.onData,
    this.ifHasData,
    this.ifNoData,
    this.onError,
  }) {
    _scenario = Scenario<T>(
      steps: [
        ScenarioStep<T>(
          make: (_) async => await future,
        ),
      ],
    );
  }

  factory LoadScenario.fromScenario({
    @required Scenario<T> scenario,
    VoidCallback onLoad,
    LoadScenarioDataCallback<T> onData,
    LoadScenarioDataCallback<T> ifHasData,
    VoidCallback ifNoData,
    ErrorScenarioCallback onError,
  }) {
    return LoadScenario<T>(
      future: scenario
          .run()
          .then((Result<T> r) => r.data)
          .catchError((e) => onError(Exception(e.message))),
      onLoad: onLoad,
      onData: onData,
      ifHasData: ifHasData,
      ifNoData: ifNoData,
      onError: onError,
    );
  }

  Future<T> call() {
    return run();
  }

  Future<T> run() async {
    T data;

    onLoad?.call();

    try {
      data = (await _scenario.run()).data;
      if (data == null) {
        ifNoData?.call();
      } else {
        ifHasData?.call(data);
      }
      onData?.call(data);
    } catch (e) {
      onError?.call(e);
    }

    return data;
  }
}
