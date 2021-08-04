import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/modules/weather/ui/res/text_styles.dart';

/// Экран ошибки
class WeatherViewError extends StatelessWidget {
  const WeatherViewError({
    Key? key,
    required this.inputPadding,
    required this.dividerPadding,
  }) : super(key: key);

  final double inputPadding;
  final double dividerPadding;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Something went wrong, try again',
            style: hl5Style,
          ),
          Divider(
            thickness: 3,
            color: Colors.white,
            endIndent: inputPadding + dividerPadding,
            indent: inputPadding + dividerPadding,
          ),
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
