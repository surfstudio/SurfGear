import 'package:flutter/foundation.dart';
import 'package:logger/src/strategies/log_strategy.dart';

///Стратегия для вывода лога в консоль
///* используется для локального дебага
class DebugLogStrategy extends LogStrategy {
  @override
  void log(String message, [int priority, Exception error]) {
    if (error != null) {
      debugPrint("ERROR: $error");
    }

    debugPrint(message);
  }
}
