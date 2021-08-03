import 'package:flutter/material.dart';
import 'package:weather/modules/weather/ui/res/text_styles.dart';

class WeatherViewLoading extends StatelessWidget {
  const WeatherViewLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Center(
        child: Text('Enter City Name', style: hl5Style),
      ),
    );
  }
}
