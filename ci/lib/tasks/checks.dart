import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/services/runner/shell_runner.dart';
import 'package:ci/tasks/check_dependency_stable.dart';
import 'package:ci/tasks/pub_check_release_version_task.dart';
import 'package:ci/tasks/pub_dry_run_task.dart';

/// Проверяет изменились ли модули, отмеченные как stable.
/// Если есть изменённые — выбрасывает исключение со списком модулей.
void checkStableModulesForChanges(List<Element> elements) {
  final changedModules =
      elements.where((e) => e.isStable && e.changed).toList();

  if (changedModules.isNotEmpty) {
    final modulesNames = changedModules.map((e) => e.name).join(', ');
    throw StableModulesWasModifiedException(
        'Модули, отмеченные как stable, были изменены: $modulesNames');
  }
}

/// Ищет изменения в указанных модулях, опираясь на разницу
/// между двумя последними коммитами.
Future<List<Element>> findChangedElements(List<Element> elements) async {
  final result = await sh('git diff --name-only HEAD HEAD~');
  final diff = result.stdout as String;

  print('Файлы, изменённые в последнем коммите:\n$diff');

  return elements.where((e) => diff.contains(e.path)).toList();
}

/// Проверка на возможность публикации пакета  модулей openSource
/// true - документ openSource и можно публиковать
/// false - документ не openSource
/// error -  докумет openSource, но публиковать нельзя
/// dart ci check_dry_run element
Future<bool> checkDryRunTask(Element element) {
  return PubDryRunTask(element).run();
}

/// Проверка на наличие актуальной версии в Release Notes
/// dart ci pub_check_release_version element
Future<bool> checkPubCheckReleaseVersionTask(Element element) {
  return PubCheckReleaseVersionTask(element).run();
}

/// Проверка стабильности зависимостей элемента
Future<bool> checkDependenciesStable(Element element) =>
    CheckDependencyStable(element).run();
