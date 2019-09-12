import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_crashlytics/flutter_crashlytics.dart';
import 'package:flutter_template/config/env/env.dart';
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
