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
import 'package:flutter_crashlytics/flutter_crashlytics.dart';
import 'package:logger/logger.dart';

/// Strategy for sending logs to Crashlytics
class CrashlyticsRemoteLogStrategy extends RemoteUserLogStrategy {
  FlutterCrashlytics get _crashlytics => FlutterCrashlytics();

  @override
  void setUser(String id, String username, String email) {
    _crashlytics.setUserInfo(id, email, username);
  }

  @override
  void clearUser() {
    _crashlytics.setUserInfo("", "", "");
  }

  @override
  void log(String message) {
    _crashlytics.log(message);
  }

  @override
  void logError(Exception error) {
    _crashlytics.onError(
      FlutterErrorDetails(
        exception: error,
      ),
    );
  }

  @override
  void logInfo(String key, info) {
    _crashlytics.setInfo(key, info);
  }
}
