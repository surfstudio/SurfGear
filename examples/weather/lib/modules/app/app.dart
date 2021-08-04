import 'package:flutter/material.dart';
import 'package:weather/modules/weather/ui/screens/app/weather_app.dart';

/// создание MaterialApp и запуск модуля "погода"
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather and News',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.white,
      ),
      home: WeatherApp(),
    );
  }
}
