import 'package:ci/tasks/increment_unstable_version_task.dart';
import 'package:test/test.dart';

import 'core/test_helper.dart';

void main() {
  group(
    'Check utility to increase unstable version.',
        () {
      test(
        'If the library is not ready to be used in production ',
            () async {
          var element = createTestElement(isStable: false);
          var task = IncrementUnstableVersionTask(element);
          var res = await task.run();

          expect(res.unstableVersion, 1);
        },
      );

      test(
        'If the module was changed as part of a pull request.',
            () async {
          var element = createTestElement(isChanged: true);
          var task = IncrementUnstableVersionTask(element);
          var res = await task.run();

          expect(res.unstableVersion, 1);
        },
      );

      test(
        'If the library is not ready to be used in production or If the module was changed as part of a pull request.',
            () async {
          var element = createTestElement(isChanged: true, isStable: false);
          var task = IncrementUnstableVersionTask(element);
          var res = await task.run();

          expect(res.unstableVersion, 1);
        },
      );
    },
  );
}
