import 'package:flutter/material.dart';
import 'package:weather/modules/weather/ui/screens/app/weather_app_dependencies.dart';
import 'package:weather/modules/weather/ui/screens/weather_screen/weather_screen.dart';

/// запуск главного экрана погоды с зависмостями
class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WeatherAppDependencies(
      app: WeatherScreen(),
    );
  }
}
