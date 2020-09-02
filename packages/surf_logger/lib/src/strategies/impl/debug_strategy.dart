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

import 'package:surf_logger/surf_logger.dart';
import 'package:surf_logger/src/const.dart';
import 'package:surf_logger/src/strategies/log_strategy.dart';

/// Strategy for log output to console
/// * used for local debugging
class DebugLogStrategy extends LogStrategy {
  @override
  void log(String message, int priority, [Exception error]) {
    if (error != null) {
      Logger.e(message, error);
    } else {
      _logMessage(message, priority);
    }
  }

  void _logMessage(String message, int priority) {
    switch (priority) {
      case priorityLogDebug:
        Logger.d(message);
        break;
      case priorityLogWarn:
        Logger.w(message);
        break;
      case priorityLogError:
        Logger.e(message);
        break;
      default:
        Logger.d(message);
    }
  }
}
