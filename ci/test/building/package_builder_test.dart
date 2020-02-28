import 'dart:io';

import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/impl/building/package_builder_task.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../core/test_helper.dart';

void main() {
  group(
    'Package builder tests:',
    () {
      test(
        'build module without example should not throw exception',
        () async {
          var element = Element(uri: Uri.directory('test/package'));
          var dm = FileSystemManagerMock();
          when(dm.getEntitiesInDirectory(element.uri.path))
              .thenReturn([]);

          var buildTask = PackageBuilderTask(element, dm);

          expectNoThrow(() async {
            await buildTask.run();
          });
        },
      );

      test(
        'build module shuld call flutter build',
        () async {
          var examplePath = 'test/package/example';
          var element = Element(uri: Uri.directory('test/package'));
          var dm = FileSystemManagerMock();
          when(dm.getEntitiesInDirectory(element.uri.path))
              .thenReturn([Directory('test/package/example')]);
          when(dm.isDirectory(examplePath)).thenReturn(true);

          var shell = ShellMock();
          when(shell.run('flutter', ['build', 'apk'])).thenAnswer(
            (_) => Future.value(
              ProcessResult(0, 0, '', ''),
            ),
          );
          substituteShell();
      var shm = getTestShellManager();
      when(shm.copy(any)).thenReturn(shell);

          var buildTask = PackageBuilderTask(element, dm);

          await buildTask.run();

          verify(shell.run('flutter', ['build', 'apk'])).called(1);
        },
      );

      test(
        'build module shuld not throw exception if build success',
        () {
          _testBuild(true, returnsNormally);
        },
      );

      test(
        'build module shuld not throw PackageBuildException if build fail',
        () {
          _testBuild(false, throwsA(TypeMatcher<PackageBuildException>()));
        },
      );
    },
  );
}

Future<void> _testBuild(bool success, matcher) async {
  var examplePath = 'test/package/example';
  var element = Element(uri: Uri.directory('test/package'));
  var dm = FileSystemManagerMock();
  when(dm.getEntitiesInDirectory(element.uri.path))
      .thenReturn([Directory('test/package/example')]);
  when(dm.isDirectory(examplePath)).thenReturn(true);

  var shell = ShellMock();
  when(shell.run('flutter', ['build', 'apk'])).thenAnswer(
    (_) => Future.value(
      ProcessResult(0, success ? 0 : 1, '', ''),
    ),
  );
  substituteShell();
  var shm = getTestShellManager();
  when(shm.copy(any)).thenReturn(shell);

  var buildTask = PackageBuilderTask(element, dm);

  expect(() async => await buildTask.run(), matcher);
}
