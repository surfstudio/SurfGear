import 'package:ci/tasks/increment_unstable_version_task.dart';
import 'package:test/test.dart';

import 'core/test_helper.dart';

/// Тест для [IncrementUnstableVersionTask]
void main() {
  group(
    'IncrementUnstableVersionTask test:',
    () {
      test(
        'If the element is stable and has not been changed, it returns 0.',
        () async {
          var res = await _prepareTestTask(isStable: true, isChanged: false).run();
          expect(res.unstableVersion, 0);
        },
      );

      test(
        'If the element is stable but has been changed , it returns 0.',
        () async {
          var res = await _prepareTestTask(isStable: true, isChanged: true).run();
          expect(res.unstableVersion, 0);
        },
      );

      test(
        'The element is not stable and has been changed.',
        () async {
          var res = await _prepareTestTask(isStable: false, isChanged: true).run();
          expect(res.unstableVersion, 1);
        },
      );
    },
  );
}

IncrementUnstableVersionTask _prepareTestTask({bool isChanged, bool isStable}) {
  var element = createTestElement(isChanged: isChanged, isStable: isStable);
  return IncrementUnstableVersionTask(element);
}
