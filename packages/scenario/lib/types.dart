import 'package:scenario/result.dart';

typedef LoadScenarioCallback = void Function(String id);
typedef ErrorScenarioCallback = void Function(Exception e);
typedef ResultScenarioCallback<T> = void Function (Result<T> result);
typedef LoadScenarioDataCallback<T> = void Function(T data);
typedef ScenarioMakeCallback<T> = Future<T> Function(dynamic prevStepData);
typedef PredicateConditionalStep = Future<bool> Function(dynamic prevStepData);
typedef ScenarioFinishCallback =  void Function(Result result);