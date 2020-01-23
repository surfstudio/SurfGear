import 'dart:io';

import 'package:ci/services/managers/shell_manager.dart';
import 'package:meta/meta.dart';
import 'package:shell/shell.dart';

/// Глобальный аллиас для запуска команд.
Future<ProcessResult> sh(String command,
    {List<String> arguments, String path}) {
  var parsed = command.split(' ');
  var cmd = parsed[0];
  parsed.remove(cmd);

  arguments = (arguments ?? <String>[])..addAll(parsed);

  return ShellRunner.instance.run(
    cmd,
    arguments: arguments,
    path: path,
  );
}

/// Утилита запуска консольных команд.
class ShellRunner {
  static ShellRunner _instance;

  static ShellRunner get instance => _instance ??= ShellRunner._();

  final _shell = Shell();
  Shell _testShell;

  ShellManager _manager = ShellManager();

  Shell get shell => _testShell ?? _shell;

  ShellRunner._();

  /// Запускает переданную команду на выполнение.
  Future<ProcessResult> run(String command,
      {List<String> arguments, String path}) {
    arguments = arguments ?? <String>[];

    var shell = path != null ? _manager.copy(this.shell) : this.shell;
    if (path != null) {
      shell.navigate(path);
    }

    return shell.run(command, arguments);
  }

  @visibleForTesting
  void mockShell(Shell shell, {ShellManager manager}) {
    _testShell = shell;

    if (manager != null) {
      _manager = manager;
    }
  }

  @visibleForTesting
  void resetMocking() {
    _manager = ShellManager();
    _testShell = null;
  }
}
