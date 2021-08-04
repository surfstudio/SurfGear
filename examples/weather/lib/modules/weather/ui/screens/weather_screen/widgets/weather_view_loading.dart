import 'package:flutter/material.dart';

/// Индикатор загрузки

class WeatherViewLoading extends StatelessWidget {
  const WeatherViewLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
