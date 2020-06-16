import 'package:scenario/result.dart';

typedef void ErrorScenarioCallback([Exception e]);
typedef void ResultScenarioCallback<T>(Result<T> result);