import 'dart:io';

import 'package:shell/shell.dart';

/// Глобальный аллиас для запуска команд.
Future<ProcessResult> sh(String command,
    {List<String> arguments, String path}) {
  var parsed = command.split(' ');
  var cmd = parsed[0];
  parsed.remove(cmd);

  arguments = (arguments ?? <String>[])..addAll(parsed);

  return ShellRunner.run(
    cmd,
    arguments: arguments,
    path: path,
  );
}

/// Утилита запуска консольных команд.
class ShellRunner {
  static final _shell = Shell();

  /// Запускает переданную команду на выполнение.
  static Future<ProcessResult> run(String command,
      {List<String> arguments, String path}) {
    arguments = arguments ?? <String>[];

    var shell = path != null ? Shell.copy(_shell) : _shell;
    if (path != null) {
      shell.navigate(path);
    }

    return shell.run(command, arguments);
  }
}
