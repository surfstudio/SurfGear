import 'package:flutter/cupertino.dart';
import 'package:scenario/steps/step_scenario.dart';
import 'package:scenario/result.dart';
import 'package:relation/relation.dart';
import 'package:scenario/scenarios/base_scenario.dart';
import 'package:scenario/scenarios/scenario.dart';

/// Сценарий загрузки данных
class LoadScenario extends BaseScenario {
  final EntityStreamedState streamedState;
  /// Сценарий загрузки
  final Scenario loadScenario;
  /// Сценарий обработки данных
  final Scenario dataScenario;
  /// Сценарий ошибки
  final Scenario errorScenario;

  LoadScenario({
    @required this.streamedState,
    this.loadScenario,
    this.dataScenario,
    this.errorScenario,
  });

  factory LoadScenario.fromSteps({
    BaseStepScenario loadStep,
    BaseStepScenario dataStep,
    BaseStepScenario errorStep,
  }) =>
      LoadScenario(
        loadScenario: loadStep == null ? null : Scenario(steps: [loadStep]),
        dataScenario: dataStep == null ? null : Scenario(steps: [dataStep]),
        errorScenario: errorStep == null ? null : Scenario(steps: [errorStep]),
      );

  call() {
    return run();
  }

  Future<void> run() async {
    Result result;
    /// Уходят в стрим
    try {
      streamedState.loading();

      /// Логика загрузки
      result = await loadScenario?.call();

      /// Загруженные данные передаются в сценарий данных для обработки
      /// Есть вариант оъеденить loadScenario и dataScenario
      result = await dataScenario?.call(result);

      /// Уходят в стрим
      streamedState.content(result.data.toString());
    } catch (e) {
      result = await errorScenario?.call(Result.fromError(e));
      streamedState.error(e);
    }
    return result;
  }
}
