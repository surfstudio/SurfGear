import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/src/testing_tools.dart';
import 'package:weather/modules/weather/models/weather.dart';
import 'package:weather/modules/weather/ui/screens/weather_screen/widgets/weather_view_ok.dart';

void main() {
  const String weatherJson =
      '{"coord":{"lon":-0.1257,"lat":51.5085},"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"base":"stations","main":{"temp":18.84,"feels_like":18.76,"temp_min":16.61,"temp_max":21.81,"pressure":1003,"humidity":76},"visibility":10000,"wind":{"speed":6.17,"deg":160},"clouds":{"all":40},"dt":1628175620,"sys":{"type":2,"id":268730,"country":"GB","sunrise":1628137828,"sunset":1628192550},"timezone":3600,"id":2643743,"name":"London","cod":200}';

  final weatherDecoded = jsonDecode(weatherJson) as Map<String, dynamic>;

  final Weather weatherData = Weather.fromJson(weatherDecoded);

  group(
    'Weather view showing weather',
    () {
      testWidgets(
        'Showing weather',
        (tester) async {
          await tester.pumpWidgetBuilder(
            Scaffold(
              body: Column(
                children: [
                  WeatherViewOk(
                      weather: weatherData,
                      inputPadding: 10,
                      dividerPadding: 10),
                ],
              ),
            ),
          );

          expect(find.text('Pressure: '), findsOneWidget);
          expect(find.text('Humidity: '), findsOneWidget);
          expect(find.text('Wind: '), findsOneWidget);
        },
      );
    },
  );
}
