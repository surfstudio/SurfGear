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

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Strategy for sending logs to Crashlytics
class CrashlyticsRemoteLogStrategy extends RemoteUserLogStrategy {
  Crashlytics get _crashlytics => Crashlytics.instance;

  @override
  void setUser(String id, String username, String email) {
    _crashlytics.setUserIdentifier(id);
    _crashlytics.setUserName(username);
    _crashlytics.setUserEmail(email);
  }

  @override
  void clearUser() {
    _crashlytics.setUserIdentifier('');
    _crashlytics.setUserName('');
    _crashlytics.setUserEmail('');
  }

  @override
  void log(String message) {
    _crashlytics.log(message);
  }

  @override
  void logError(Exception error) {
    _crashlytics.recordError(
      error,
      FlutterErrorDetails(exception: error).stack,
    );
  }

  @override
  void logInfo(String key, info) {
    if (info is bool) {
      _crashlytics.setBool(key, info);
      return;
    }

    if (info is double) {
      _crashlytics.setDouble(key, info);
      return;
    }

    if (info is int) {
      _crashlytics.setInt(key, info);
      return;
    }

    if (info is String) {
      _crashlytics.setString(key, info);
    } else {
      _crashlytics.setString(key, info.toString());
    }
  }
}
