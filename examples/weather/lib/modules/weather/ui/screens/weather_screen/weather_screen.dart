import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:weather/modules/weather/models/weather.dart';
import 'package:weather/modules/weather/ui/decorations/input_text_decoration.dart';
import 'package:weather/modules/weather/ui/res/assets.dart';
import 'package:weather/modules/weather/ui/res/ui_constants.dart';
import 'package:weather/modules/weather/ui/screens/weather_screen/weather_screen_wm.dart';
import 'package:weather/modules/weather/ui/screens/weather_screen/widgets/wather_view_error.dart';
import 'package:weather/modules/weather/ui/screens/weather_screen/widgets/weather_view_loading.dart';
import 'package:weather/modules/weather/ui/screens/weather_screen/widgets/weather_view_ok.dart';

/// главный экран погоды
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
            double inputPadding = standardPadding * 2;
            final width = constraints.maxWidth;
            if (width > maxCityInputWidth + standardPadding * 2) {
              inputPadding = (width - maxCityInputWidth) / 2;
            }

            return StreamedStateBuilder<String>(
                streamedState: wm.backgroundsState,
                builder: (context, snapshot) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.7), BlendMode.dstATop),
                        image: AssetImage(
                            '$baseImagesPath/${snapshot.toLowerCase()}.jpg'),
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
                                    inputPadding,
                                    standardPadding,
                                    inputPadding,
                                    standardPadding),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      child: FaIcon(
                                          FontAwesomeIcons.mapMarkerAlt,
                                          size: 40),
                                      onTap: wm.findCityByGeo,
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(15, 0, 15, 0),
                                        child: TextFormField(
                                          style: TextStyle(fontSize: 20),
                                          cursorColor: Colors.white,
                                          decoration: inputTextDecoration(
                                              'Enter City Name'),
                                          controller:
                                              wm.cityInputAction.controller,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      child: FaIcon(
                                          FontAwesomeIcons.searchLocation,
                                          size: 40),
                                      onTap: wm.fetchInput,
                                    ),
                                  ],
                                ),
                              ),

                              /// стейтбилдер показывает разные экраны в зависимости от состояния ответа
                              EntityStateBuilder<Weather>(
                                streamedState: wm.weathertState,
                                builder: (_, data) => WeatherViewOk(
                                    weather: data,
                                    inputPadding: inputPadding,
                                    dividerPadding: dividerPadding),
                                loadingChild: WeatherViewLoading(),
                                errorBuilder: (_, e) => WeatherViewError(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
