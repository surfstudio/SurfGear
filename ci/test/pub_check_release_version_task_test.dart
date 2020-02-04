import 'dart:io';

import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/pub_check_release_version_task.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'core/test_helper.dart';

void main() {
  group(
    'Check if the module version matches the specified CHANGELOG.md.',
        () {
      test(
        'If the module version matches, we will return true.',
            () async {
          var shell = ShellMock();
          when(shell.run('pub', ['publish', '--dry-run']))
              .thenAnswer((_) => Future.value(ProcessResult(0, 0, 'test123', '')));
          substituteShell();
          var shm = getTestShellManager();
          when(shm.copy(any)).thenReturn(shell);

          var task = PubCheckReleaseVersionTask(createTestElement());
          var actual = await task.run();

          expect(
            actual,
            isTrue,
          );
        },
      );

      test(
        'If an error occurred while checking the module version, we will return an exception.',
            () async {
          var shell = ShellMock();
          when(shell.run('pub', ['publish', '--dry-run']))
              .thenAnswer((_) => Future.value(ProcessResult(0, 1, 'test123', '')));
          substituteShell();
          var shm = getTestShellManager();
          when(shm.copy(any)).thenReturn(shell);

          var task = PubCheckReleaseVersionTask(createTestElement());
          expect(
                () async => await task.run(),
            throwsA(
              TypeMatcher<ModuleNotReadyReleaseVersionFail>(),
            ),
          );
        },
      );

      test(
        'If the module version does not match CHANGELOG.md, we will return an exception',
            () async {
          var shell = ShellMock();
          when(shell.run('pub', ['publish', '--dry-run'])).thenAnswer((_) => Future.value(
              ProcessResult(0, 1, 'CHANGELOG.md doesn\'t mention current version', '')));
          substituteShell();
          var shm = getTestShellManager();
          when(shm.copy(any)).thenReturn(shell);

          var task = PubCheckReleaseVersionTask(createTestElement());
          expect(
                () async => await task.run(),
            throwsA(
              TypeMatcher<ModuleNotReadyReleaseVersion>(),
            ),
          );
        },
      );
    },
  );
}
