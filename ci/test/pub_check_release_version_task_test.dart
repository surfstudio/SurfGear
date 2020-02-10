import 'dart:io';

import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/pub_check_release_version_task.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'core/test_helper.dart';

/// Тестируем класс [PubCheckReleaseVersionTask]
void main() {
  group(
    'PubCheckReleaseVersionTask test:',
    () {
      test(
        "If 'pub publish --dry-run' was successful, it returns true.",
        () async {
          var task = _testPreparedPubCheckReleaseVersionTask(exitCode: 0);
          var actual = await task.run();

          expect(
            actual,
            isTrue,
          );
        },
      );

      test(
        'If pub publish returned error without changelog problem, task should return true.',
        () async {
          var task = _testPreparedPubCheckReleaseVersionTask(exitCode: 1, stderr: ' test123 ');
          var actual = await task.run();

          expect(
            actual,
            isTrue,
          );
        },
      );

      test(
        'If pub publish returns an error with problems with the changelog, the task should return true.',
        () async {
          var task = _testPreparedPubCheckReleaseVersionTask(
              exitCode: 1, stderr: ' CHANGELOG.md doesn\'t mention current version ');
          expect(
            () async => await task.run(),
            throwsA(
              TypeMatcher<ChangeLogDoesNotContainCurrentVersionException>(),
            ),
          );
        },
      );
    },
  );
}

PubCheckReleaseVersionTask _testPreparedPubCheckReleaseVersionTask(
    {int exitCode = 0, String stderr = ''}) {
  var processResult = ProcessResult(0, exitCode, '', stderr);
  var callingMap = <String, dynamic>{
    'pub publish --dry-run': processResult,
  };
  var shell = substituteShell(callingMap: callingMap);
  var shm = getTestShellManager();
  when(shm.copy(any)).thenReturn(shell);
  return PubCheckReleaseVersionTask(createTestElement());
}
