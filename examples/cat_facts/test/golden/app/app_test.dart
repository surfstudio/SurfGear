import 'dart:ui';

import 'package:cat_facts/data/facts/fact.dart';
import 'package:cat_facts/data/theme/app_theme.dart';
import 'package:cat_facts/ui/app/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:relation/relation.dart';

import '../core/golden_app_wrapper.dart';

/// Голден тесты [App]
void main() {
  const _factList = [
    Fact(content: 'Some fact text'),
    Fact(content: 'One more fact text'),
    Fact(content: 'One more fact text. Long long loooooooooong fact.'),
  ];

  late StreamedState<AppTheme> themeStream;
  late MockThemeInteractor themeInteractor;
  late MockFactsInteractor factsInteractor;

  setUp(() async {
    themeStream = StreamedState<AppTheme>(AppTheme.light);
    themeInteractor = MockThemeInteractor();
    factsInteractor = MockFactsInteractor();

    when(() => factsInteractor.getFacts(count: any(named: 'count')))
        .thenAnswer((_) => Future.value(_factList));
    when(() => themeInteractor.appTheme).thenReturn(themeStream);

    await loadAppFonts();
  });

  testGoldens(
    'App golden test',
    (tester) async {
      await tester.pumpWidget(
        GoldenAppWrapper(
          factsInteractor: factsInteractor,
          themeInteractor: themeInteractor,
          app: const App(),
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
