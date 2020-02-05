import 'dart:io';

import 'package:ci/domain/config.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/services/runner/shell_runner.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:path/path.dart' as path;

/// Зеркалирует open source модуль в его отдельный репозиторий
class MirrorOpenSourceModuleTask implements Task<bool> {
  static const remoteAlreadyExistsCode = 128;

  final Element element;

  MirrorOpenSourceModuleTask(this.element)
      : assert(element.openSourceInfo?.separateRepoUrl != null);

  @override
  Future<bool> run() async {
    final repoUrl = element.openSourceInfo.separateRepoUrl;
    final remoteName = '${element.name}-subtree';

    final addRemote = 'git remote add $remoteName $repoUrl';
    final addRemoteResult = await sh(addRemote, path: Config.repoRootPath);

    if (addRemoteResult.exitCode != 0 &&
        addRemoteResult.exitCode != remoteAlreadyExistsCode) {
      _throwModuleMirroringException(element.name, addRemoteResult);
    }

    final modulePath = path
        .relative(element.path, from: Config.repoRootPath)
        .replaceAll('\\', '/');

    final prefix = '--prefix=${modulePath}';

    final pushSubtree = 'git subtree push $prefix $remoteName master';
    final pushResult = await sh(pushSubtree, path: Config.repoRootPath);

    if (pushResult.exitCode != 0) {
      _throwModuleMirroringException(element.name, pushResult);
    }

    return true;
  }

  void _throwModuleMirroringException(String moduleName, ProcessResult result) {
    final error = '${result.stdout}$result.stderr}';
    final message = getMirroringExceptionText(moduleName, error);
    throw ModuleMirroringException(message);
  }
}
