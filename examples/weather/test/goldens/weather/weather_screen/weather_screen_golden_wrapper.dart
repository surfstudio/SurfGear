import 'package:flutter/material.dart';

class WeatherScreenGoldenWrapper extends StatelessWidget {
  final Widget testWidget;

  const WeatherScreenGoldenWrapper({
    Key? key,
    required this.testWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          testWidget,
        ],
      ),
    );
  }
}
