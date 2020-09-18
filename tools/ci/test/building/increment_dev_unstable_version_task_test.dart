import 'package:ci/tasks/impl/building/increment_dev_version_task.dart';
import 'package:test/test.dart';

import '../core/test_helper.dart';

/// Тест для [IncrementUnstableVersionTask]
var testDevVersion = '0.0.1-dev.0';
var testDevVersionIncremented = '0.0.1-dev.1';

void main() {
  group(
    'IncrementDevUnstableVersionTask test:',
    () {
      test(
        'If the element is stable and has not been changed, it returns same version.',
        () async {
          var res = await _prepareTestTask(
            isStable: true,
            isChanged: false,
          ).run();
          expect(res.version, testDevVersion);
        },
      );

      test(
        'If the element is stable but has been changed, it returns same version.',
        () async {
          var res =
              await _prepareTestTask(isStable: true, isChanged: true).run();
          expect(res.version, testDevVersion);
        },
      );

      test(
        'The element is not stable and has been changed.',
        () async {
          var res =
              await _prepareTestTask(isStable: false, isChanged: true).run();
          expect(res.version, testDevVersionIncremented);
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
  var element = createTestElement(
    isChanged: isChanged,
    isStable: isStable,
    version: testDevVersion,
  );
  return IncrementDevVersionTask(element);
}
