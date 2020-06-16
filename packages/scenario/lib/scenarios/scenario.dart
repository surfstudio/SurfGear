import 'package:scenario/steps/step_scenario.dart';
import 'package:scenario/result.dart';
import 'package:scenario/scenarios/base_scenario.dart';
import 'package:scenario/types.dart';

/// Стандартный Сценарий
class Scenario<T> extends BaseScenario {
  /// Шаги
  final List<BaseStepScenario> steps;
  /// Колбэк окончания работы сценария
  final void Function(Result result) onFinish;
  /// Колбэк окончания работы сценария
  final ErrorScenarioCallback onError;

  Scenario({
    this.steps,
    this.onFinish,
    this.onError,
  });


  Future<Result<T>> run([Result prevScenarioResult]) async {
    var result = prevScenarioResult?.data;
    try {
      for (BaseStepScenario step in steps) {
        result = await step(result);
      }
      onFinish?.call(Result(result));
    } catch (e) {
      onError?.call(e);
      return Result.fromError(e);
    }
    return Result(result);
  }

  Future<Result> call([prevScenarioData]) async {
    return run(prevScenarioData);
  }
}