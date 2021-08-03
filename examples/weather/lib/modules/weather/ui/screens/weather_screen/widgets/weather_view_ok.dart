import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/modules/weather/models/weather.dart';
import 'package:weather/modules/weather/ui/res/text_styles.dart';

class WeatherViewOk extends StatelessWidget {
  const WeatherViewOk(
      {Key? key,
      required this.weather,
      required this.inputPadding,
      required this.dividerPadding})
      : super(key: key);

  final Weather weather;
  final double inputPadding;
  final double dividerPadding;

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var formatter = new DateFormat.yMMMMd('en_US');
    String formattedDate = formatter.format(now);

    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(weather.name, style: hl2Style),
          Text(formattedDate, style: hl5Style),
          Text('${weather.main.temp.toInt()}°', style: hl1Style),
          Text(
              '${weather.main.tempMin.toInt()}° / ${weather.main.tempMax.toInt()}°',
              style: hl5Style),
          Text('${weather.weather[0].main}', style: hl5Style),
          Text('${weather.weather[0].description}', style: hl5Style),
          Divider(
            thickness: 3,
            color: Colors.white,
            endIndent: inputPadding + dividerPadding,
            indent: inputPadding + dividerPadding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Pressure: ', style: hl5Style),
                  Text('Humidity: ', style: hl5Style),
                  Text('Wind: ', style: hl5Style),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${weather.main.pressure} mmHg', style: hl5StyleBold),
                  Text('${weather.main.humidity} g/m3', style: hl5StyleBold),
                  Text('${weather.wind.speed} m/s', style: hl5StyleBold),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
