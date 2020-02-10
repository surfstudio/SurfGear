import 'dart:io';

import 'package:ci/domain/element.dart';
import 'package:ci/services/managers/file_system_manager.dart';
import 'package:ci/services/managers/license_manager.dart';
import 'package:ci/services/managers/shell_manager.dart';
import 'package:ci/services/pubspec_parser.dart';
import 'package:ci/services/runner/shell_runner.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:ci/tasks/factories/license_task_factory.dart';
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

final ShellMock _shellForTest = ShellMock();
final ShellManagerMock _shellManagerForTest = ShellManagerMock();

/// Подменяет шелл у раннера и возвращает экземпляр замены.
ShellMock substituteShell({
  Map<String, dynamic> callingMap,
}) {
  var mock = _shellForTest;
  setupShell(mock, callingMap);

  ShellRunner.init(shell: mock, manager: _shellManagerForTest);
  return mock;
}

/// Создает экземпляр шелл, но не регистрирует его у раннера.
///
/// Например может быть полезно для создания копии шелл который вернет менеджер.
ShellMock createShell({
  Map<String, dynamic> callingMap,
}) {
  var mock = _shellForTest;
  reset(mock);
  var mock = ShellMock();
  setupShell(mock, callingMap);

  return mock;
}

/// Выполняет настройку шелл по переданной мапе вызывов.
void setupShell(ShellMock shell, Map<String, dynamic> callingMap) {
  reset(shell);

  callingMap?.forEach((command, result) {
    var parsed = command.split(' ');
    var cmd = parsed[0];
    parsed.remove(cmd);

    ProcessResult answer;
    if (result is ProcessResult) {
      answer = result;
    }

    if (result is bool) {
      answer = result ? createPositiveResult() : createErrorResult();
    }

    when(shell.run(cmd, parsed)).thenAnswer(
      (_) => Future.value(
        answer ?? createPositiveResult(),
      ),
    );
  });
}

/// Возвращает замену менеджера shell, зарегистрированную в runner.
///
/// Метод может быть вызван только после вызова substituteShell, иначе бесполезен.
ShellManagerMock getTestShellManager() {
  reset(_shellManagerForTest);

  return _shellManagerForTest;
}

/// Возвращает замену менеджера shell, зарегистрированную в runner.
///
/// Метод может быть вызван только после вызова substituteShell, иначе бесполезен.
ShellManagerMock getTestShellManager() {
  reset(_shellManagerForTest);

  return _shellManagerForTest;
}

/// Тестовый ответ на консольную команду, сценарий без ошибки.
ProcessResult createPositiveResult({
  dynamic stdout = 'test out',
  dynamic stderr,
}) =>
    ProcessResult(
      0,
      0,
      stdout,
      stderr,
    );

/// Тестовый ответ на консольную команду, сценарий с ошибкой.
ProcessResult createErrorResult({
  int exitCode = 1,
  dynamic stdout,
  dynamic stderr = 'test error',
}) =>
    ProcessResult(
      0,
      exitCode,
      stdout,
      stderr,
    );

/// File System Manager

class FileSystemManagerMock extends Mock implements FileSystemManager {}

/// Shell Manager

class ShellManagerMock extends Mock implements ShellManager {}

/// License manager

class LicenseManagerMock extends Mock implements LicenseManager {}

/// Замена менеджера лицензий
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

  return mock;
}

/// Element

Element createTestElement({
  String name = 'testName',
  String path = 'test/path',
  bool isStable = false,
  bool isChanged = false,
  int unstableVersion = 0,
}) {
  return Element(
      name: name,
      uri: Uri.directory(path),
      isStable: isStable,
      changed: isChanged,
      unstableVersion: unstableVersion);
}

/// License Task Factory

class LicenseTaskFactoryMock extends Mock implements LicenseTaskFactory {}

/// Pubspec Parser

class PubspecParserMock extends Mock implements PubspecParser {}
