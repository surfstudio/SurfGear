import 'package:flutter/material.dart';
import 'package:weather/modules/weather/ui/res/text_styles.dart';

class WeatherViewError extends StatelessWidget {
  const WeatherViewError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Center(
        child: Text('Something went wrong', style: hl5Style),
      ),
    );
  }
}
