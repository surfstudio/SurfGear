import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:weather/modules/weather/ui/screens/weather_screen/widgets/wather_view_error.dart';

import '../weather_screen_golden_wrapper.dart';

/// Голден тесты [App]
void main() {
  setUp(() async {
    await loadAppFonts();
  });

  testGoldens(
    'App golden test',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: WeatherScreenGoldenWrapper(
            testWidget: WeatherViewError(inputPadding: 10, dividerPadding: 10),
          ),
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
          const Device(size: Size(400, 900), name: 'custom 1'),
        ],
      );
    },
  );
}
