import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather in any location'),
      ),
      body: Container(
        child: Center(
          child: Text('yo tho'),
        ),
      ),
    );
  }
}
