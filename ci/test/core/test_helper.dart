import 'package:ci/services/managers/file_system_manager.dart';
import 'package:ci/services/managers/shell_manager.dart';
import 'package:ci/services/runner/shell_runner.dart';
import 'package:mockito/mockito.dart';
import 'package:shell/shell.dart';
import 'package:test/test.dart';

/// Common

/// Проверяем что выполнение не выбросит исключения.
void expectNoThrow(
  actual, {
  String reason,
  skip,
}) =>
    expect(actual, returnsNormally, reason: reason, skip: skip);

/// Shell part

class ShellMock extends Mock implements Shell {}

/// Подменяет шелл у раннера и возвращает экземпляр замены.
ShellMock substituteShell({ShellManager manager}) {
  var mock = ShellMock();
  ShellRunner.init(shell: mock, manager: manager);
  return mock;
}

/// Directory Manager

class DirectoryManagerMock extends Mock implements FileSystemManager {}

/// Shell Manager

class ShellManagerMock extends Mock implements ShellManager {}

ShellManagerMock createShellManagerMock({Shell copy}) {
  var mock = ShellManagerMock();
  when(mock.copy(any)).thenReturn(copy);
  return mock;
}
