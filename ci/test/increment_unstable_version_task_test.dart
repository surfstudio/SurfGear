import 'package:ci/tasks/increment_unstable_version_task.dart';
import 'package:test/test.dart';

import 'core/test_helper.dart';

void main() {
  group(
    'Check task to increase unstable version.',
    () {
      test(
        'If the library is not ready to be used in production, task should return 1.',
        () async {
          var res = await _testReturnPreparedTask(isStable: false).run();
          expect(res.unstableVersion, 1);
        },
      );

      test(
        'If the library was changed as part of the pull request, task should return 1.',
        () async {
          var res = await _testReturnPreparedTask(isChanged: true).run();
          expect(res.unstableVersion, 1);
        },
      );

      test(
        'If the library was changed as part of the pull request and if the library is not ready to be used in production, task should return 1.',
        () async {
          var res = await _testReturnPreparedTask(isChanged: true, isStable: false).run();
          expect(res.unstableVersion, 1);
        },
      );

      test(
        'If the library has not been modified as part of the retrieval request and if the library is ready for use in a production environment, the task should return 0.',
        () async {
          var res = await _testReturnPreparedTask(isChanged: false, isStable: true).run();
          expect(res.unstableVersion, 0);
        },
      );
    },
  );
}

IncrementUnstableVersionTask _testReturnPreparedTask({bool isChanged = false, bool isStable = true}) {
  var element = createTestElement(isChanged: isChanged, isStable: isStable);
  return IncrementUnstableVersionTask(element);
}
