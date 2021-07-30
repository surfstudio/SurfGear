import 'package:flutter/material.dart';
import 'package:mwwm_example/features/app/presentation/app.dart';
import 'package:mwwm_example/features/app/presentation/di/injection_container.dart';

Future<void> run() async {
  runApp(const InjectionContainer(child: App()));
}
