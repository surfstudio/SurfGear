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

import 'package:logger/src/const.dart';
import 'package:logger/src/remote_logger.dart';
import 'package:logger/src/strategies/log_strategy.dart';

const minRemotePriority = PRIORITY_LOG_WARN;

/// Strategy for sending logs to a remote server
/// * logs are sent starting from [minRemotePriority]
class RemoteLogStrategy extends LogStrategy {
  @override
  void log(String message, int priority, [Exception error]) {
    if (priority < minRemotePriority) return;

    RemoteLogger.log(message);

    if (error != null) {
      RemoteLogger.logError(error);
    }
  }
}
