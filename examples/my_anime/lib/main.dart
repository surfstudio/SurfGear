import 'package:flutter/material.dart';
import 'package:my_anime/data/storage/hive/hive_setup.dart';
import 'package:my_anime/ui/app/app.dart';
import 'package:my_anime/ui/app/app_component.dart';
import 'package:surf_injector/surf_injector.dart';

Future<void> main() async {
  await hiveSetup();

  runApp(
    Injector(
      component: AppComponent(),
      builder: (_) => const App(),
    ),
  );
}
