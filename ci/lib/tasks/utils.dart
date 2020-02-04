import 'dart:io';

import 'package:ci/domain/config.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/services/runner/shell_runner.dart';
import 'package:path/path.dart' as path;

const remoteAlreadyExistsCode = 128;

/// Получить модули, помеченные как stable.
List<Element> getStableModules(List<Element> elements) {
  return elements.where((e) => e.isStable).toList();
}

/// Ищет изменения в указанных модулях, опираясь на разницу
/// между двумя последними коммитами.
Future<List<Element>> findChangedElements(List<Element> elements) async {
  await markChangedElements(elements);

  return filterChangedElements(elements);
}

/// Возвращает элеметны из списка, которые имеют отметку об изменении.
Future<List<Element>> filterChangedElements(List<Element> elements) async {
  return elements.where((e) => e.changed).toList();
}

/// Помечает измененные модули, опираясь на разницу
/// между двумя последними коммитами.
Future<void> markChangedElements(List<Element> elements) async {
  final result = await sh('git diff --name-only HEAD HEAD~');
  final diff = result.stdout as String;

  print('Файлы, изменённые в последнем коммите:\n$diff');

  elements
      .where((e) => diff.contains(e.directoryName))
      .forEach((e) => e.changed = true);
}

/// Пушит open source модули в отдельные репозитории
Future<void> mirrorOpenSourceModules(List<Element> elements) async {
  final hasRepo = (Element e) => e.openSourceInfo?.separateRepoUrl != null;
  final openSourceModules = elements.where(hasRepo).toList();

  for (var module in openSourceModules) {
    final repoUrl = module.openSourceInfo.separateRepoUrl;
    final remoteName = '${module.name}-subtree';

    final addRemote = 'git remote add $remoteName $repoUrl';
    final addRemoteResult = await sh(addRemote, path: Config.repoRootPath);

    if (addRemoteResult.exitCode != 0 &&
        addRemoteResult.exitCode != remoteAlreadyExistsCode) {
      _throwModuleMirroringException(module.name, addRemoteResult);
    }

    final modulePath = path
        .relative(module.path, from: Config.repoRootPath)
        .replaceAll('\\', '/');

    final prefix = '--prefix=${modulePath}';

    final pushSubtree = 'git subtree push $prefix $remoteName master';
    final pushResult = await sh(pushSubtree, path: Config.repoRootPath);

    if (pushResult.exitCode != 0) {
      _throwModuleMirroringException(module.name, pushResult);
    }
  }
}

void _throwModuleMirroringException(String moduleName, ProcessResult result) {
  final error = '${result.stdout}$result.stderr}';
  final message = getMirroringExceptionText(moduleName, error);
  throw ModuleMirroringException(message);
}
