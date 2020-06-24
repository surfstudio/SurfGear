import 'package:flutter/foundation.dart';
import 'package:scenario/result.dart';
import 'package:scenario/scenarios/base_scenario.dart';
import 'package:scenario/scenarios/scenario.dart';
import 'package:scenario/steps/step_scenario.dart';
import 'package:scenario/types.dart';

/// Сценарий загрузки данных
class LoadScenario<T> extends BaseScenario {
  /// Колбэк начала загрузки
  VoidCallback onLoad;

  /// Колбэк получения данных
  LoadScenarioDataCallback<T> onData;

  /// Колбэк если есть кэшированные данные
  LoadScenarioDataCallback<T> ifHasData;

  /// Колбэк если нет кэшированных данны
  VoidCallback ifNoData;

  /// Колбэк поустых данных
  VoidCallback onEmpty;

  /// Колбэк ошибки
  ErrorScenarioCallback onError;

  /// Нужно ли кэшировать данные последнего запроса
  final bool isCached;

  Scenario<T> _scenario;

  T _prevData;

  LoadScenario({
    @required ScenarioMakeCallback<T> make,
    this.onLoad,
    this.onData,
    this.ifHasData,
    this.ifNoData,
    this.onEmpty,
    this.onError,
    bool isCached,
  }) : isCached = isCached ?? false {
    _scenario = Scenario<T>(
      steps: [
        ScenarioStep<T>(
          make: make,
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
      make: (_) async => await scenario
          .run()
          .then(
            (Result<T> r) => r.data,
          )
          .catchError(
            (e) => onError(
              Exception(e.message),
            ),
          ),
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

    if (_prevData == null) {
      ifNoData?.call();
    } else {
      ifHasData?.call(data);
    }

    try {
      data = (await _scenario.run()).data;
      if (data == null) {
        onEmpty?.call();
      } else {
        onData?.call(data);
      }
      if (isCached) _prevData = data;
    } catch (e) {
      onError?.call(e);
    }

    return data;
  }
}
