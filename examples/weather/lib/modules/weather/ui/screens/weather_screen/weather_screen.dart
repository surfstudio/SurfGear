import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mwwm/mwwm.dart';
import 'package:weather/modules/weather/ui/decorations/input_text_decoration.dart';
import 'package:weather/modules/weather/ui/res/assets.dart';
import 'package:weather/modules/weather/ui/res/text_styles.dart';
import 'package:weather/modules/weather/ui/res/ui_constants.dart';
import 'package:weather/modules/weather/ui/screens/weather_screen/weather_screen_wm.dart';

class WeatherScreen extends CoreMwwmWidget<WeatherScreenWidgetModel> {
  WeatherScreen({Key? key})
      : super(
          key: key,
          widgetModelBuilder: (context) =>
              createWeatherScreenWidgetModel(context),
        );

  @override
  WidgetState<CoreMwwmWidget<WeatherScreenWidgetModel>,
      WeatherScreenWidgetModel> createWidgetState() {
    return _WeatherScreen();
  }
}

class _WeatherScreen
    extends WidgetState<WeatherScreen, WeatherScreenWidgetModel> {
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
            double inputpadding = standardPadding * 2;
            final width = constraints.maxWidth;
            if (width > maxCityInputWidth + standardPadding * 2) {
              inputpadding = (width - maxCityInputWidth) / 2;
            }

            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.7), BlendMode.dstATop),
                  image: AssetImage(genericBackground),
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
                          padding: EdgeInsets.fromLTRB(inputpadding,
                              standardPadding, inputpadding, standardPadding),
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
                              Text('Moscow', style: hl2Style),
                              Text('30 July 2021', style: hl5Style),
                              Text('32°', style: hl1Style),
                              Text('Cloudy', style: hl5Style),
                              Text('Scattered Clouds', style: hl5Style),
                              Divider(
                                thickness: 3,
                                color: Colors.white,
                                endIndent: inputpadding + dividerPadding,
                                indent: inputpadding + dividerPadding,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('99 mmHg', style: hl5StyleBold),
                                      Text('99 g/m3', style: hl5StyleBold),
                                      Text('99 m/s', style: hl5StyleBold),
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
