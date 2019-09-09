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

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_crashlytics/flutter_crashlytics.dart';
import 'package:flutter_template/config/base/env/env.dart';
import 'package:flutter_template/ui/app/app.dart';
import 'package:logger/logger.dart';

void run() async {
  // закрепляем ориентацию todo изменить на необходимое или убрать
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  _initCrashlytics();
  _initLogger();
  _runApp();
}

void _runApp() {
  runZoned<Future<Null>>(
    () async {
      runApp(App());
    },
    onError: (error, stack) async {
      await FlutterCrashlytics().reportCrash(
        error,
        stack,
        forceCrash: true, //todo убрать forceCrash
      );
    },
  );
}

void _initCrashlytics() async {
  bool isDebug = Environment.instance().isDebug;
  FlutterError.onError = (FlutterErrorDetails details) async {
    if (isDebug) {
      // In development mode simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode report to the application zone to report to
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  await FlutterCrashlytics().initialize();
}

void _initLogger() {
  RemoteLogger.addStrategy(CrashlyticsRemoteLogStrategy());
  Logger.addStrategy(DebugLogStrategy());
  Logger.addStrategy(RemoteLogStrategy());
}
