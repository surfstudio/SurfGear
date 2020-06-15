import 'package:flutter/cupertino.dart';

import 'mixins.dart';
import 'scenario.dart';

/// Шаг сценария
abstract class StepScenario<T> {

  Future<bool> call([T data]) {
    return calculate(data);
  }

  /// Вычисления результата шага
  @protected
  Future<bool> calculate([T data]);
}

/// Предикат для [PredicateStep]
typedef Future<bool> PredicateStepCallback<T>(T data);

/// Шаг основанный на предкате
class PredicateStep<T> extends StepScenario<T> {
  PredicateStepCallback<T> _predicate;
  
  PredicateStep(this._predicate);

  @override
  Future<bool> calculate([T data]) {
    return _predicate(data);
  }

}

/// Частный случай шага
class LoadCompleteStep<T> extends StepScenario<T> {
  @override
  Future<bool> calculate([_]) {
    return Future.value(true);
  }
}

/// Step со своими колбэками
abstract class ConditionalStep<T> extends StepScenario<T> with CallerFunction {

void Function(T data) doCallback;
VoidCallback notCallback;

@override
  Future<bool> calculate([T data]) async {
    return run(data);
  }

  Future<bool> run([T data]);

  ConditionalStep ifDo(void Function(T data) callback) {
    doCallback = callback;
    return this;
  }

  ConditionalStep ifNot(VoidCallback callback) {
    notCallback = callback;
    return this;
  }
}

class RequestStep<T> extends ConditionalStep<T> {
  
  @override
  Future<bool> run([T data]) async {
    ///Имитация обработки
    await Future.delayed(Duration(seconds: 1));
    if(data == null) {
      callFn(notCallback);
    } else {
      callFn(doCallback, data);
    }
    return true;
  } 
}