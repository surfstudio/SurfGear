import 'package:scenario/steps/step_scenario.dart';
import 'package:scenario/types.dart';

/// Стандартный Сценарий
class Scenario<T> {
  /// Шаги
  final List<BaseScenarioStep> steps;

  /// Колбэк окончания работы сценария
  final ScenarioFinishCallback onFinish;

  /// Колбэк окончания работы сценария
  final ErrorScenarioCallback onError;

  Scenario({
    List<BaseScenarioStep> steps,
    this.onFinish,
    this.onError,
  }) : steps = steps ?? [];

  Future<void> run() async {
    try {
      for (BaseScenarioStep step in steps) {
        await step();
      }
    } catch (e) {
      onError?.call(e);
    }
    onFinish?.call();
  }

  Future<void> call() async {
    return run();
  }
}
