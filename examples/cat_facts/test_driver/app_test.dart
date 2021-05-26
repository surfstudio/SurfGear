// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:surf_lint_rules/surf_lint_rules.dart';
import 'package:test/test.dart';

void main() {
  group('Cat facts app', () {
    final switchStateFinder = find.byValueKey('theme_status');
    final switchButtonFinder = find.byValueKey('theme_switcher');

    late FlutterDriver driver;

    setUp(() async {
      driver = await FlutterDriver.connect();
    });

    tearDown(() async {
      unawaited(driver.close());
    });

    test('starts at light theme', () async {
      expect(await driver.getText(switchStateFinder), 'Switch Off');
    });

    test('switch theme', () async {
      await driver.tap(switchButtonFinder);

      expect(await driver.getText(switchStateFinder), 'Switch On');
    });

    test('switch theme second times', () async {
      await driver.tap(switchButtonFinder);

      expect(await driver.getText(switchStateFinder), 'Switch Off');
    });
  });
}
