import 'package:ci/services/managers/directory_manager.dart';
import 'package:ci/services/managers/shell_manager.dart';
import 'package:ci/services/runner/shell_runner.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:shell/shell.dart';

/// Shell part

@visibleForTesting
class ShellMock extends Mock implements Shell {}

/// Подменяет шелл у раннера и возвращает экземпляр замены.
@visibleForTesting
ShellMock substituteShell({ShellManager manager}) {
  var mock = ShellMock();
  ShellRunner.instance.mockShell(mock, manager: manager);
  return mock;
}

/// Отменяет подмену шелла.
@visibleForTesting
void resetShellSubstitution() => ShellRunner.instance.resetMocking();

/// Directory Manager

@visibleForTesting
class DirectoryManagerMock extends Mock implements DirectoryManager {}

/// Shell Manager

@visibleForTesting
class ShellManagerMock extends Mock implements ShellManager {}

ShellManagerMock createShellManagerMock({Shell copy}) {
  var mock = ShellManagerMock();
  when(mock.copy(any)).thenReturn(copy);
  return mock;
}