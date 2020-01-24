import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/runner/shell_runner.dart';
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
Future<bool> checkDryRunTask(List<Element> elements) {
  return PubDryRunTask(elements).run();
}
