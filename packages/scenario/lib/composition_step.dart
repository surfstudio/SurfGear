import 'package:flutter/cupertino.dart';
import 'package:scenario/result.dart';
import 'package:scenario/types.dart';

/// Базовый класс шага
abstract class BaseStepScenario<T> {

  /// Функция получения результата
  ResultScenarioCallback<T> onResult;

  /// Зависимые шаги
  @protected
  List<BaseStepScenario> nextSteps = [];

  BaseStepScenario({this.onResult});

  Future<BaseStepScenario> call([data]);

  BaseStepScenario to(BaseStepScenario step) {
    nextSteps.add(step);
    return this;
  }
}

class StepScenario<T> extends BaseStepScenario<T> {
  Future<T> future;

  StepScenario({
    ResultScenarioCallback<T> onResult,
    this.future,
  }) : super(onResult: onResult) {
    _init();
  }

  Future<BaseStepScenario> call([data]) {
    return callSteps(data);
  }

  /// Чистая функция для вызова переданных связаных шагов
  Future<BaseStepScenario> callSteps(List<BaseStepScenario> nextSteps, [data]) async {
    var result = data;
    for (BaseStepScenario step in nextSteps) {
      result = await step.call(result);
    }
    return this;
  }

  Future<void> _init() async {
    if(future == null) return;
    var result = await future;
    onResult?.call(Result(result));
  }
}

class StreamStepScenario<T> extends BaseStepScenario<T> {
  Stream<T> stream;
  StepScenario<T> _step = StepScenario<T>();
  dynamic Function(dynamic data, T streamData) predicate;
  T _lastStreamData;

  StreamStepScenario({
    this.stream,
    this.predicate,
    ResultScenarioCallback<T> onResult,
  }) : super(onResult: onResult) {
    _init();
  }

  @override
  Future<StreamStepScenario> call([data]) async {
    var r = predicate?.call(data, _lastStreamData) ?? data;
    await _step.callSteps(nextSteps, r);
    return this;
  }

  void _init() {
    stream.listen((T data) {
      onResult?.call(Result(data));
    });
  }
}

//abstract class BaseStep<T> {
//  List<BaseStep> _nextSteps;
//  ResultScenarioCallback<T> onResult;
//
//  BaseStep({
//    this.onResult,
//  });
//
//  BaseStep to(BaseStep step) {
//    _nextSteps.add(step);
//    return this;
//  }
//
//  Future<BaseStep> call([data]) async {
//    var result = data;
//    for (BaseStep step in _nextSteps) {
//      result = await step.call(result);
//    }
//    return this;
//  }
//}
//
//mixin _StepRun<T> on BaseStep<T> {
//  Future<T> run();
//}
//
//class Step<T> extends BaseStep<T> {
//  final T Function([dynamic data]) predicate;
//
//  Step({
//    this.predicate,
//  });
//
//  @override
//  Future<BaseStep> call([data]) async {
//    predicate(data);
//    return this;
//  }
//}
//
//class FutureStep<T> extends BaseStep<T> with _StepRun<T> {
//  final Future<T> future;
//
//  FutureStep({
//    this.future,
//  });
//
//  @override
//  Future<BaseStep> call([data]) async {
//    var result = await run();
//    return super.call(result);
//  }
//
//  @override
//  Future<T> run() async {
//    return await future;
//  }
//}
//
//class StreamStep<T> extends BaseStep<T> {}
