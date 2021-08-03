import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/modules/weather/ui/res/text_styles.dart';

class WeatherViewLoading extends StatelessWidget {
  const WeatherViewLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Enter City Name and press ', style: hl5Style),
              FaIcon(FontAwesomeIcons.searchLocation),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Or press ', style: hl5Style),
              FaIcon(FontAwesomeIcons.mapMarkerAlt),
              Text(' to get your location', style: hl5Style),
            ],
          ),
        ],
      ),
    );
  }
}
