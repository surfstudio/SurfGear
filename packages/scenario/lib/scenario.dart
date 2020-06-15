import 'package:flutter/cupertino.dart';
import 'package:scenario/composition_step.dart';
import 'package:scenario/result.dart';
import 'package:scenario/types.dart';

abstract class BaseScenario {}

class Scenario extends BaseScenario {
  final List<BaseStepScenario> steps;
  final void Function(Result result) onFinish;
  final ErrorScenarioCallback onError;

  Scenario({
    this.steps,
    this.onFinish,
    this.onError,
  });

  Future<Result> run([Result prevScenarioResult]) async {
    var result = prevScenarioResult.data;
    try {
      for (BaseStepScenario step in steps) {
        result = await step(result);
      }
      onFinish?.call(Result(result));
    } catch (e) {
      onError?.call(e);
    }
    return result;
  }

  Future<Result> call([prevScenarioData]) async {
    return run(prevScenarioData);
  }
}

class LoadScenario extends BaseScenario {
  //EntityStreamedState streamedState;
  Scenario loadScenario;
  Scenario dataScenario;
  Scenario errorScenario;

  LoadScenario({
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
    try {
      result = await loadScenario?.call();
      result = await dataScenario?.call(result);
    } catch(e) {
      result = await errorScenario?.call(Result.fromError(e));
    }
    return result;
  }
}
