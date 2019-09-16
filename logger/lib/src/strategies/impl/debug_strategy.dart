// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/foundation.dart';
import 'package:logger/src/const.dart';
import 'package:logger/src/strategies/log_strategy.dart';

/// Strategy for log output to console
/// * used for local debugging
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
      case PRIORITY_LOG_DEBUG:
        return PREFIX_LOG_DEBUG;
      case PRIORITY_LOG_WARN:
        return PREFIX_LOG_WARN;
      case PRIORITY_LOG_ERROR:
        return PREFIX_LOG_ERROR;
      default:
        return "";
    }
  }
}
