import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:cat_facts/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Cat facts app switch theme end-to-end test', (tester) async {
    app.main();

    await tester.pumpAndSettle();

    final switchButtonFinder = find.byKey(const Key('theme_switcher'));

    expect(find.text('Switch Off'), findsOneWidget);

    // Emulate a tap on the floating action button.
    await tester.tap(switchButtonFinder);

    await tester.pumpAndSettle();

    expect(find.text('Switch On'), findsOneWidget);

    // Emulate a tap on the floating action button.
    await tester.tap(switchButtonFinder);

    await tester.pumpAndSettle();

    expect(find.text('Switch Off'), findsOneWidget);
  });
}
