import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/modules/weather/decorations/input_text_decoration.dart';
import 'package:weather/modules/weather/widgets/text_weather_hl2.dart';
import 'package:weather/modules/weather/widgets/text_weather_hl1.dart';
import 'package:weather/modules/weather/widgets/text_weather_hl5.dart';
import 'package:weather/modules/weather/widgets/text_weather_hl5_italic.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('News'),
        icon: const FaIcon(FontAwesomeIcons.newspaper),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            /// управление полем вовода и разденилитем на больших экранах
            double inputpadding = 20;
            final width = constraints.maxWidth;
            if (width > 680) {
              inputpadding = (width - 640) / 2;
            }

            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.7), BlendMode.dstATop),
                  image: AssetImage('assets/images/clouds.jpg'),
                ),
              ),
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              inputpadding, 10, inputpadding, 10),
                          child: Row(
                            children: [
                              FaIcon(FontAwesomeIcons.mapMarkerAlt, size: 40),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  child: TextFormField(
                                    style: TextStyle(fontSize: 20),
                                    cursorColor: Colors.white,
                                    decoration:
                                        inputTextDecoration('Enter City Name'),
                                  ),
                                ),
                              ),
                              FaIcon(FontAwesomeIcons.searchLocation, size: 40),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextWeatherHL2(text: 'Kaliningrad'),
                              TextWeatherHL5(text: '30 July 2021'),
                              TextWeatherHL1(text: '32°'),
                              TextWeatherHL5(text: 'Cloudy'),
                              TextWeatherHL5(text: 'Scattered Clouds'),
                              Divider(
                                thickness: 3,
                                color: Colors.white,
                                endIndent: inputpadding + 40,
                                indent: inputpadding + 40,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      TextWeatherHL5(text: 'Pressure: '),
                                      TextWeatherHL5(text: 'Humidity: '),
                                      TextWeatherHL5(text: 'Wind: '),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWeatherHL5Italic(text: '99 mmHg'),
                                      TextWeatherHL5Italic(text: '99 g/m3'),
                                      TextWeatherHL5Italic(text: '99 m/s'),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
