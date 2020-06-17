import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:scenario/result.dart';
import 'package:scenario/scenarios/base_scenario.dart';
import 'package:scenario/scenarios/scenario.dart';
import 'package:scenario/types.dart';

/// Сценарий загрузки данных
class LoadScenario<T> extends BaseScenario {
  Future<T> future;
  VoidCallback onLoad;
  LoadScenarioDataCallback<T> onData;
  LoadScenarioDataCallback<T> ifHasData;
  VoidCallback ifNoData;
  ErrorScenarioCallback onError;

  LoadScenario({
    @required this.future,
    this.onLoad,
    this.onData,
    this.ifHasData,
    this.ifNoData,
    this.onError,
  });

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
      data = await future;
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
