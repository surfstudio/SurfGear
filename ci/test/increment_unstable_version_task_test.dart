import 'package:ci/tasks/increment_unstable_version_task.dart';
import 'package:test/test.dart';

import 'core/test_helper.dart';

void main() {
  group(
    'Check task to increase unstable version:',
    () {
      test(
        'The module is ready for use in production.',
        () async {
          var res = await _prepareTestTask(isChanged: false, isStable: true).run();
          expect(res.unstableVersion, 0);
        },
      );
    },
  );

  group(
    'A module that is not ready for production throws an error:',
    () {
      test(
        'Not ready to be used in production.',
        () async {
          var res = await _prepareTestTask(isStable: false).run();
          expect(res.unstableVersion, 1);
        },
      );

      test(
        'The module was changed.',
        () async {
          var res = await _prepareTestTask(isChanged: true).run();
          expect(res.unstableVersion, 1);
        },
      );

      test(
        'The module was changed and not ready to be used in production.',
        () async {
          var res = await _prepareTestTask(isChanged: true, isStable: false).run();
          expect(res.unstableVersion, 1);
        },
      );
    },
  );
}

IncrementUnstableVersionTask _prepareTestTask({bool isChanged = false, bool isStable = true}) {
  var element = createTestElement(isChanged: isChanged, isStable: isStable);
  return IncrementUnstableVersionTask(element);
}
