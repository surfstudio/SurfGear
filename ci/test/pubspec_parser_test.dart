import 'package:ci/pubspec_parser.dart';
import 'package:test/test.dart';

void main() {
  test('wrong path', () {
    expect(() => parsePubspecs('.'), throwsException);
  });

  test('correct path', () {
    expect(() => parsePubspecs('../packages'), returnsNormally);
  });

  test('reference equivalence', () {
    final elements = parsePubspecs('../packages');
    final analytics = elements.firstWhere((e) => e.name == 'analytics');

    final logger = elements.firstWhere((e) => e.name == 'logger');
    final loggerAsAnalyticsDependency = analytics.dependencies
        .map((d) => d.element)
        .firstWhere((e) => e.name == 'logger');

    expect(logger == loggerAsAnalyticsDependency, true);
  });
}
