import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:relation/relation.dart';
import 'package:weather/modules/weather/ui/screens/weather_screen/widgets/search_bar.dart';

import '../../weather_screen_golden_wrapper.dart';

/// Голден тесты [App]
void main() {
  setUp(() async {
    await loadAppFonts();
  });

  testGoldens(
    'App golden test',
    (tester) async {
      await tester.pumpWidget(
        WeatherScreenGoldenWrapper(
          testWidget: SearchBar(
              inputPadding: 10,
              findCityByGeoAction: VoidAction(),
              textEditionController: ExtendedTextEditingController(),
              fetchInputAction: VoidAction()),
        ),
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
