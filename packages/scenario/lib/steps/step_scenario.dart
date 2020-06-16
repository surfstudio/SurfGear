import 'package:flutter/cupertino.dart';
import 'package:scenario/result.dart';
import 'package:scenario/types.dart';

/// Базовый класс шага
abstract class BaseStepScenario<T> {

  /// Функция получения результата
  ResultScenarioCallback<T> onResult;

  BaseStepScenario({this.onResult});

  Future<T> call([data]);
}

class StepScenario<T> extends BaseStepScenario<T> {
  Future<T> Function(dynamic prevStepData) loadMore;

  StepScenario({
    this.loadMore,
    ResultScenarioCallback<T> onResult,
  }) : super(onResult: onResult);

  Future<T> call([prevStepData]) async {
    T result = await loadMore(prevStepData);
    onResult?.call(Result(result));
    return result;
  }
}

class ConditionalStep<T> extends BaseStepScenario<T> {
  final Map<String, BaseStepScenario> steps;
  final Future<String> Function(dynamic prevStepData) predicate;

  ConditionalStep({
    @required this.predicate,
    @required this.steps,
    ResultScenarioCallback<T> onResult,
  }) : super(onResult: onResult);

  Future<T> call([prevStepData]) async {
    String id = await predicate(prevStepData);
    return steps[id]?.call(prevStepData);
  }
}

//class StreamStepScenario<T> extends BaseStepScenario<T> {
//  Stream<T> stream;
//  StepScenario<T> _step = StepScenario<T>();
//  dynamic Function(dynamic data, T streamData) predicate;
//  T _lastStreamData;
//
//  StreamStepScenario({
//    this.stream,
//    this.predicate,
//    ResultScenarioCallback<T> onResult,
//  }) : super(onResult: onResult) {
//    _init();
//  }
//
//  @override
//  Future<StreamStepScenario> call([data]) async {
//    var r = predicate?.call(data, _lastStreamData) ?? data;
//    await _step.callSteps(nextSteps, r);
//    return this;
//  }
//
//  void _init() {
//    stream.listen((T data) {
//      onResult?.call(Result(data));
//    });
//  }
//}
//---------------
//class ConditionalStep

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
