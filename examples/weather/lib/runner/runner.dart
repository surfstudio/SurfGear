import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather/config/constants.dart';
import 'package:weather/modules/app/app.dart';
import 'package:weather/modules/app/services/app_dependencies.dart';

Future<void> runApplication() async {
  /// инициализация и открытие Hive-бокса
  await Hive.initFlutter();
  await Hive.openBox(hiveBoxName);

  /// запуск приложения с зависимостями
  runApp(
    AppDependencies(
      app: App(),
    ),
  );
}
