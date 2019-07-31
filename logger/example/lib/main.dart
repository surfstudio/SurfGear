import 'package:counter/ui/app/app.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

void main() {
  _initLogger();
  runApp(App());
}

void _initLogger() {
  Logger.addStrategy(DebugLogStrategy());
}
