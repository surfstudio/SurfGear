import 'package:flutter/material.dart';
import 'package:weather/modules/weather/ui/screens/weather_screen/weather_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather and News',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.white,
      ),
      home: WeatherScreen(),
    );
  }
}
