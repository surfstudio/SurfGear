import 'package:ci/services/pubspec_parser.dart';
import 'package:test/test.dart';

void main() {
  test('wrong path', () {
    expect(() => PubspecParser().parsePubspecs('.'), throwsException);
  });

  test('correct path', () {
    expect(() => PubspecParser().parsePubspecs('../packages'), returnsNormally);
  });

  test('reference equivalence', () {
    final elements = PubspecParser().parsePubspecs('../packages');
    final analytics = elements.firstWhere((e) => e.name == 'analytics');

    final logger = elements.firstWhere((e) => e.name == 'logger');
    final loggerAsAnalyticsDependency = analytics.dependencies
        .map((d) => d.element)
        .firstWhere((e) => e.name == 'logger');

    expect(logger == loggerAsAnalyticsDependency, true);
  });
}
