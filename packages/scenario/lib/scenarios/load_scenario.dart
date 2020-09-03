import 'package:flutter/foundation.dart';
import 'package:scenario/scenarios/scenario.dart';
import 'package:scenario/steps/step_scenario.dart';
import 'package:scenario/types.dart';

/// Сценарий загрузки данных
class LoadScenario<T> extends Scenario<T> {
  T _prevData;

  LoadScenario({
    @required ScenarioMakeCallback<T> make,

    /// Колбэк начала загрузки
    LoadScenarioCallback onLoad,

    /// Колбэк если есть кэшированные данные
    LoadScenarioDataCallback<T> ifHasData,

    /// Колбэк если нет кэшированных данных
    VoidCallback ifNoData,

    /// Колбэк получения данных
    LoadScenarioDataCallback<T> onData,

    /// Колбэк ошибки
    ErrorScenarioCallback onError,

    /// Колбэк окончания работы сценария
    ScenarioFinishCallback onFinish,

    /// Нужно ли кэшировать данные последнего запроса
    bool isCached,
  }) : super(
          onFinish: onFinish,
          onError: onError,
        ) {
    steps.addAll(
      [
        ScenarioStep<T>(
          onLoad: onLoad,
          make: ([_]) async {
            return make(_prevData);
          },
          ifHasData: ifHasData,
          ifNoData: ifNoData,
          onData: (data) {
            if (isCached ?? false) {
              _prevData = data;
            }
          },
          onError: onError,
        ),
      ],
    );
  }
}
