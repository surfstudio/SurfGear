import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_template/config/build_types.dart';
import 'package:flutter_template/config/env/env.dart';
import 'package:flutter_template/ui/app/app.dart';

//Main entry point of app
void main() async {
  // закрепляем ориентацию
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  Environment.init(buildType: BuildType.release);

  _initCrashlytics();
  _runApp();
}

void _runApp() {
  runZoned<Future<Null>>(() async {
    runApp(App());
  });
}

void _initCrashlytics() {
  bool isDebug = Environment.instance().isDebug;
  Crashlytics.instance.enableInDevMode = isDebug;
  FlutterError.onError = (FlutterErrorDetails details) {
    if (isDebug) {
      // In development mode simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode report to the application zone to report to
      // Crashlytics.
      Crashlytics.instance.onError(details);
    }
  };
}
