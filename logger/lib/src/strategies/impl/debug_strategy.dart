/// Copyright (c) 2019-present,  SurfStudio LLC
/// 
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
/// 
///     http://www.apache.org/licenses/LICENSE-2.0
/// 
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

import 'package:flutter/foundation.dart';
import 'package:logger/src/const.dart';
import 'package:logger/src/strategies/log_strategy.dart';

///Стратегия для вывода лога в консоль
///* используется для локального дебага
class DebugLogStrategy extends LogStrategy {
  @override
  void log(String message, int priority, [Exception error]) {
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
