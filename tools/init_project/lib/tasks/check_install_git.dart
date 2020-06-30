import 'package:shell/shell.dart';

/// Проверяем, установлен ли git
class CheckInstallGit {
  Future<void> check() async {
    final shell = Shell();

    final processResult = await shell.run('git', ['--help']);
    if (processResult.exitCode != 0) {
      return Future.error(Exception('git not found, install git of https://git-scm.com'));
    }
  }
}
