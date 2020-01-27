import 'package:ci/domain/element.dart';
import 'package:ci/services/factories/license_task_factory.dart';
import 'package:ci/services/managers/file_system_manager.dart';
import 'package:ci/services/managers/license_manager.dart';
import 'package:ci/services/managers/shell_manager.dart';
import 'package:ci/services/runner/shell_runner.dart';
import 'package:ci/tasks/core/task.dart';
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

/// Подмена задачи
class TaskMock<T> extends Mock implements Task<T> {}

/// Замена задачи, которая завершается успешно
TaskMock<T> createSuccessTask<T>({T result}) {
  var mock = TaskMock<T>();
  when(mock.run()).thenAnswer((_) => Future.value(result));

  return mock;
}

/// Замена задачи, которая завершается ошибкой
TaskMock<T> createFailTask<T>({Exception exception}) {
  exception ??= Exception('test');
  var mock = TaskMock<T>();
  when(mock.run()).thenAnswer((_) => Future.error(exception));

  return mock;
}

/// Shell part

class ShellMock extends Mock implements Shell {}

/// Подменяет шелл у раннера и возвращает экземпляр замены.
ShellMock substituteShell({ShellManager manager}) {
  var mock = ShellMock();
  ShellRunner.init(shell: mock, manager: manager);
  return mock;
}

/// File System Manager

class FileSystemManagerMock extends Mock implements FileSystemManager {}

/// Shell Manager

class ShellManagerMock extends Mock implements ShellManager {}

ShellManagerMock createShellManagerMock({Shell copy}) {
  var mock = ShellManagerMock();
  when(mock.copy(any)).thenReturn(copy);
  return mock;
}

/// License manager

class LicenseManagerMock extends Mock implements LicenseManager {}

LicenseManagerMock createLicenseManagerMock({
  String license,
  String copyright,
}) {
  var mock = LicenseManagerMock();

  if (license != null) {
    when(mock.getLicense()).thenAnswer((_) => Future.value(license));
  }

  if (copyright != null) {
    when(mock.getCopyright()).thenAnswer((_) => Future.value(copyright));
  }
}

/// Element

Element createTestElement({String path = 'test/path'}) {
  return Element(path: path);
}

/// License Task Factory

class LicenseTaskFactoryMock extends Mock implements LicenseTaskFactory {}