import 'dart:io';

import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/package_builder_task.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../core/test_helper.dart';

void main() {
  test(
    'build module without example should not throw exception',
    () async {
      var element = Element(path: 'test/package');
      var dm = DirectoryManagerMock();
      when(dm.getEntitiesInDirectory(element.path, recursive: true))
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
      var element = Element(path: 'test/package');
      var dm = DirectoryManagerMock();
      when(dm.getEntitiesInDirectory(element.path, recursive: true))
          .thenReturn([Directory('test/package/example')]);
      when(dm.isDirectory(examplePath)).thenReturn(true);

      var shell = ShellMock();
      when(shell.run('flutter', ['build', 'apk'])).thenAnswer(
        (_) => Future.value(
          ProcessResult(0, 0, '', ''),
        ),
      );
      var shm = createShellManagerMock(copy: shell);
      substituteShell(manager: shm);

      var buildTask = PackageBuilderTask(element, dm);

      await buildTask.run();

      verify(shell.run('flutter', ['build', 'apk'])).called(1);
    },
  );

  test(
    'build module shuld not throw exception if build success',
    () async {
      expectNoThrow(() async {
        await _testBuild(true);
      });
    },
  );

  test(
    'build module shuld not throw PackageBuildException if build fail',
    () async {
      expect(() async {
        await _testBuild(false);
      }, throwsA(TypeMatcher<PackageBuildException>()));
    },
  );
}

void _testBuild(bool success) async {
  var examplePath = 'test/package/example';
  var element = Element(path: 'test/package');
  var dm = DirectoryManagerMock();
  when(dm.getEntitiesInDirectory(element.path, recursive: true))
      .thenReturn([Directory('test/package/example')]);
  when(dm.isDirectory(examplePath)).thenReturn(true);

  var shell = ShellMock();
  when(shell.run('flutter', ['build', 'apk'])).thenAnswer(
    (_) => Future.value(
      ProcessResult(0, success ? 0 : 1, '', ''),
    ),
  );
  var shm = createShellManagerMock(copy: shell);
  substituteShell(manager: shm);

  var buildTask = PackageBuilderTask(element, dm);

  await buildTask.run();
}
