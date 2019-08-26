import 'package:flutter/foundation.dart';
import 'package:logger/src/const.dart';
import 'package:logger/src/strategies/log_strategy.dart';

///Стратегия для вывода лога в консоль
///* используется для локального дебага
class DebugLogStrategy extends LogStrategy {
  @override
  void log(String message, int priority, [dynamic error]) {
    if (error != null) {
      debugPrint("ERROR: $error");
    }

    final logMessage = "${_mapPrefix(priority)} $message";
    debugPrint(logMessage);
  }

  String _mapPrefix(int priority) {
    switch (priority) {
      case 1:
        return PREFIX_LOG_DEBUG;
      case 2:
        return PREFIX_LOG_WARN;
      case 3:
        return PREFIX_LOG_ERROR;
      default:
        return "";
    }
  }
}
