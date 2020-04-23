import 'dart:io';

import 'package:ci/domain/config.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/services/runner/shell_runner.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:path/path.dart' as path;
import 'dart:convert' show utf8;

/// Зеркалирует open source модуль в его отдельный репозиторий
class MirrorOpenSourceModuleTask implements Task<bool> {
  final Element element;

  MirrorOpenSourceModuleTask(this.element) {
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
      return parts[0] + r'\\' + '${Uri.encodeComponent(Platform.environment['USERNAME'])}:${Uri.encodeComponent(Platform.environment['PASSWORD'])}@' + parts[1];
    }();

    // push only to stable branch, yet
    final pushSubtree = 'git subtree push $prefix $repoWithCreds stable';
    final pushResult = await sh(pushSubtree, path: Config.repoRootPath);

    if (pushResult.exitCode != 0) {
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
