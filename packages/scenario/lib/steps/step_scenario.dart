import 'package:flutter/cupertino.dart';
import 'package:scenario/result.dart';
import 'package:scenario/types.dart';

/// Базовый класс шага
abstract class BaseScenarioStep<T> {
  /// Функция получения результата
  ResultScenarioCallback<T> onResult;

  BaseScenarioStep({this.onResult});

  Future<T> call([data]);
}

class ScenarioStep<T> extends BaseScenarioStep<T> {
  ScenarioMakeCallback<T> make;

  ScenarioStep({
    this.make,
    ResultScenarioCallback<T> onResult,
  }) : super(onResult: onResult);

  Future<T> call([prevStepData]) async {
    T result = await make(prevStepData);
    onResult?.call(Result(result));
    return result;
  }
}

/// Шаг с выполеннеием по условию
/// Если [predicate] вернет true - выполнить [firstStep] иначе [secondStep]
class ConditionalScenarioStep<T> extends BaseScenarioStep<T> {
  /// Первый шаг
  final BaseScenarioStep firstStep;

  /// Второй шаг
  final BaseScenarioStep secondStep;

  /// Предикат определяющй какой шаг выполнять
  final PredicateConditionalStep predicate;

  ConditionalScenarioStep({
    @required this.predicate,
    @required this.firstStep,
    @required this.secondStep,
    ResultScenarioCallback<T> onResult,
  }) : super(onResult: onResult);

  Future<T> call([prevStepData]) async {
    bool isFirst = await predicate(prevStepData);
    return isFirst
        ? await firstStep?.call(prevStepData)
        : await secondStep?.call(prevStepData);
  }
}
