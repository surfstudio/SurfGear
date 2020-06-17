import 'package:scenario/result.dart';

typedef void ErrorScenarioCallback(Exception e);
typedef void ResultScenarioCallback<T>(Result<T> result);
typedef void LoadScenarioDataCallback<T>(T data);
typedef Future<T> ScenarioMakeCallback<T>(dynamic prevStepData);
typedef Future<bool> PredicateConditionalStep(dynamic prevStepData);