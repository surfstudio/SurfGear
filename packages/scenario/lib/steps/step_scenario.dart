import 'package:flutter/cupertino.dart';
import 'package:scenario/result.dart';
import 'package:scenario/types.dart';

/// Базовый класс шага
abstract class BaseScenarioStep<T> {
  /// Функция получения результата
  ResultScenarioCallback<T> onResult;

  BaseScenarioStep({this.onResult});

  Future<T> call();
}

class ScenarioStep<T> extends BaseScenarioStep<T> {
  String id;
  ScenarioMakeCallback<T> make;
  LoadScenarioCallback onLoad;
  LoadScenarioDataCallback<T> ifHasData;
  VoidCallback ifNoData;
  LoadScenarioDataCallback<T> onData;
  ErrorScenarioCallback onError;

  ScenarioStep({
    this.id,
    this.make,
    this.onLoad,
    this.ifHasData,
    this.ifNoData,
    this.onData,
    this.onError,
    ResultScenarioCallback<T> onResult,
  }) : super(onResult: onResult);

  Future<T> call() async {
    onLoad?.call(id);

    T data = await make();
    Result<T> result;

    try {
      data = await make();
      if (data == null) {
        ifNoData?.call();
      } else {
        ifHasData?.call(data);
      }
      onData?.call(data);
      result = Result(data);
    } catch (e, s) {
      result = Result.fromError(e);
      onError?.call(e);
    }
    onResult?.call(result);
    return result.data;
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
        ? await firstStep?.call()
        : await secondStep?.call();
  }
}
