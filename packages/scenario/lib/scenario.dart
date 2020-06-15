import 'package:flutter/cupertino.dart';
import 'package:scenario/composition_step.dart';
import 'package:scenario/types.dart';

abstract class BaseScenario {}

class Scenario<Result> extends BaseScenario {
  final List<BaseStepScenario> steps;
  final VoidCallback onFinish;
  final ErrorScenarioCallback onError;

  Scenario({
    this.steps,
    this.onFinish,
    this.onError,
  });

  void run() async {
    try {
      await Future.wait(steps.map((step) => step()));
      onFinish?.call();
    } catch (e) {
      onError?.call(e);
    }
  }

  Scenario call() {
    run();
    return this;
  }
}
/// Древоидный вариант
class LoadScenario extends BaseScenario {
  EntityStreamedState streamedState;

  LoadScenario() {
    _init();
  }

  call() {
    run();
  }

  void run() {
    Scenario();
  }

  void _init() {}
}
