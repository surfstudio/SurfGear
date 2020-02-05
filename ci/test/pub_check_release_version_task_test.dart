import 'dart:io';

import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/pub_check_release_version_task.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'core/test_helper.dart';

void main() {
  group(
    'Check whether the module version matches the specified CHANGELOG.md:',
    () {
      test(
        'The version matched.',
        () async {
          var task = _testPreparedPubCheckReleaseVersionTask(stderr: ' test123 ');
          var actual = await task.run();

          expect(
            actual,
            isTrue,
          );
        },
      );

      test(
        'The version didn\'t match',
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
