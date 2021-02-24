import 'package:ci/tasks/impl/building/increment_dev_version_task.dart';
import 'package:ci/tasks/impl/building/increment_unstable_version_task.dart';
import 'package:test/test.dart';

import '../core/test_helper.dart';

/// Тест для [IncrementUnstableVersionTask]
const _testDevVersion = '0.0.1-dev.0';
const _testDevVersionIncremented = '0.0.1-dev.1';

const _testWithoutPostfixDevVersion = '0.0.1';
const _testWithoutPostfixDevVersionIncremented = '0.0.1-dev.0';

void main() {
  group(
    'IncrementDevUnstableVersionTask test:',
    () {
      test(
        'If the element is stable and has not been changed, it returns same version.',
        () async {
          final res = await _prepareTestTask(
            isStable: true,
            isChanged: false,
            version: _testDevVersion,
          ).run();
          expect(res.version, _testDevVersion);
        },
      );

      test(
        'If the element is stable but has been changed, it returns same version.',
        () async {
          final res = await _prepareTestTask(
            isStable: true,
            isChanged: true,
            version: _testDevVersion,
          ).run();
          expect(res.version, _testDevVersion);
        },
      );

      test(
        'The element is not stable and has been changed.',
        () async {
          final res = await _prepareTestTask(
            isStable: false,
            isChanged: true,
            version: _testDevVersion,
          ).run();
          expect(res.version, _testDevVersionIncremented);
        },
      );

      test(
        'The element is not stable, has been changed and version without "dev".',
        () async {

          final res = await _prepareTestTask(
            isStable: false,
            isChanged: true,
            version: _testWithoutPostfixDevVersion,
          ).run();
          expect(res.version, _testWithoutPostfixDevVersionIncremented);
        },
      );
    },
  );
}

IncrementDevVersionTask _prepareTestTask({
  bool isChanged,
  bool isStable,
  String version,
}) {
  final element = createTestElement(
    isChanged: isChanged,
    isStable: isStable,
    version: version ?? _testDevVersion,
  );
  return IncrementDevVersionTask(element);
}
