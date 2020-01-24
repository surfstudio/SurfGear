import 'dart:io';

import 'package:ci/services/managers/shell_manager.dart';
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

  Shell _shell;
  ShellManager _manager;

  ShellRunner.init({Shell shell, ShellManager manager}) {
    _instance ??= ShellRunner._(shell: shell, manager: manager);
  }

  ShellRunner._({Shell shell, ShellManager manager})
      : _shell = shell ?? Shell(),
        _manager = manager ?? ShellManager();

  /// Запускает переданную команду на выполнение.
  Future<ProcessResult> run(String command,
      {List<String> arguments, String path}) {
    arguments = arguments ?? <String>[];

    var shell = path != null ? _manager.copy(_shell) : _shell;
    if (path != null) {
      shell.navigate(path);
    }

    return shell.run(command, arguments);
  }
}
