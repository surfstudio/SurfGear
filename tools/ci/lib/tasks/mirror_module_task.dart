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
  final Element element;
  final String branchName;

  MirrorOpenSourceModuleTask(
    this.element,
    this.branchName,
  ) {
    if (element.openSourceInfo?.separateRepoUrl == null) {
      final message = getModuleIsNotOpenSourceExceptionText(element.name);
      throw ModuleIsNotOpenSourceException(message);
    }
  }

  @override
  Future<bool> run() async {
    final repoUrl = element.openSourceInfo.separateRepoUrl;

    final modulePath = path
        .relative(element.path, from: Config.repoRootPath)
        .replaceAll('\\', '/');

    final prefix = '--prefix=${modulePath}';

    final repoWithCreds = () {
      var parts = repoUrl.split('//').toList(); // two parts
      return parts[0] +
          '//' +
          '${Uri.encodeComponent(Platform.environment['USERNAME'])}:${Uri.encodeComponent(Platform.environment['PASSWORD'])}@' +
          parts[1];
    }();

     // After submitting the changes, you need to get them back
    final pullSubtreeBefore = 'git subtree pull -m "[skip_ci] pull subtree before" $prefix $repoWithCreds $branchName';
    final pullResultBefore = await sh(pullSubtreeBefore, path: Config.repoRootPath);
    if (pullResultBefore.exitCode != 0) {
      _throwModuleMirroringException(element.name, pushResult);
    }

    // push to mirror commits for module only
    final pushSubtree = 'git subtree push $prefix $repoWithCreds $branchName';
    final pushResult = await sh(pushSubtree, path: Config.repoRootPath);
    if (pushResult.exitCode != 0) {
      _throwModuleMirroringException(element.name, pushResult);
    }

    // After submitting the changes, you need to get them back
    final pullSubtree = 'git subtree pull -m "[skip_ci] pull subtree" $prefix $repoWithCreds $branchName';
    final pullResult = await sh(pullSubtree, path: Config.repoRootPath);
    if (pullResult.exitCode != 0) {
      _throwModuleMirroringException(element.name, pushResult);
    }

    final pushLocal = 'git push';
    final pushLocalResult = await sh(pushLocal, path: Config.repoRootPath);
    if (pushLocalResult.exitCode != 0) {
      _throwModuleMirroringException(element.name, pushResult);
    }

    return true;
  }

  void _throwModuleMirroringException(String moduleName, ProcessResult result) {
    final error = '${result.stdout}${result.stderr}';
    final message = getMirroringExceptionText(moduleName, error);
    throw ModuleMirroringException(message);
  }
}
