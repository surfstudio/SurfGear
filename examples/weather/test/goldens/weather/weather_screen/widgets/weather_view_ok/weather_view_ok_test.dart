import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:weather/modules/weather/models/weather.dart';
import 'package:weather/modules/weather/ui/screens/weather_screen/widgets/weather_view_ok.dart';

import '../../weather_screen_golden_wrapper.dart';

/// Голден тесты [App]
void main() {
  String weatherJson =
      '{"coord":{"lon":-0.1257,"lat":51.5085},"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"base":"stations","main":{"temp":18.84,"feels_like":18.76,"temp_min":16.61,"temp_max":21.81,"pressure":1003,"humidity":76},"visibility":10000,"wind":{"speed":6.17,"deg":160},"clouds":{"all":40},"dt":1628175620,"sys":{"type":2,"id":268730,"country":"GB","sunrise":1628137828,"sunset":1628192550},"timezone":3600,"id":2643743,"name":"London","cod":200}';

  final weatherDecoded = jsonDecode(weatherJson) as Map<String, dynamic>;

  final testWeather = Weather.fromJson(weatherDecoded);

  setUp(() async {
    await loadAppFonts();
  });

  testGoldens(
    'App golden test',
    (tester) async {
      await tester.pumpWidget(
        WeatherScreenGoldenWrapper(
            testWidget: WeatherViewOk(
                weather: testWeather, inputPadding: 10, dividerPadding: 10)),
      );

      await tester.waitForAssets();
      await tester.pump();

      await multiScreenGolden(
        tester,
        'toolkit_app_test',
        devices: [
          Device.phone,
          Device.tabletPortrait,
          Device.iphone11,
          Device.tabletPortrait,
          const Device(size: Size(400, 900), name: 'custom_400x900'),
          const Device(size: Size(800, 600), name: 'custom_800x600'),
        ],
      );
    },
  );
}
