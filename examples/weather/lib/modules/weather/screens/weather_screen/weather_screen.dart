import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/modules/weather/decorations/input_text_decoration.dart';
import 'package:weather/modules/weather/widgets/text_weather_hl2.dart';
import 'package:weather/modules/weather/widgets/text_weather_hl1.dart';
import 'package:weather/modules/weather/widgets/text_weather_hl4.dart';
import 'package:weather/modules/weather/widgets/text_weather_hl4_italic.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: const Text('News'),
        icon: const FaIcon(FontAwesomeIcons.newspaper),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Container(
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
                    Padding(padding: EdgeInsets.all(10)),
                    Container(
                      padding: EdgeInsets.all(20),
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
                          TextWeatherHL4(text: '30 July 2021'),
                          TextWeatherHL1(text: '32°'),
                          TextWeatherHL4(text: 'Cloudy'),
                          TextWeatherHL4(text: 'Scattered Clouds'),
                          Divider(
                            thickness: 3,
                            color: Colors.white,
                            endIndent: 30,
                            indent: 30,
                          ),
                          // TextWeatherHL4(text: '--------------------------'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  TextWeatherHL4(text: 'Pressure: '),
                                  TextWeatherHL4(text: 'Humidity: '),
                                  TextWeatherHL4(text: 'Wind: '),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWeatherHL4Italic(text: '99 mmHg'),
                                  TextWeatherHL4Italic(text: '99 g/m3'),
                                  TextWeatherHL4Italic(text: '99 m/s'),
                                ],
                              ),
                            ],
                          ),
                          // TextWeatherHL4(text: 'Cloudy'),
                          // TextWeatherHL4(text: 'Scattered Clouds'),
                          // TextWeatherHL4(text: 'Pressure: 1000'),
                          // TextWeatherHL4(text: 'Humidity: 1000'),
                          // TextWeatherHL4(text: 'Wind Speed: 100 m/s'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
