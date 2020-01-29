import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/check_dependency_stable.dart';
import 'package:ci/tasks/linter_check.dart';

import 'package:ci/tasks/pub_check_release_version_task.dart';
import 'package:ci/tasks/pub_dry_run_task.dart';
import 'package:ci/tasks/stable_modules_for_changes_check.dart';

/// Проверка модулей с помощью `flutter analyze`.
Future<bool> checkModulesWithLinter(List<Element> elements) async {
  var errorMessages = <String>[];

  for (var element in elements) {
    try {
      await CheckModuleWithLinter(element).run();
    } catch (errorMessage) {
      errorMessages.add(errorMessage);
    }
  }

  if (errorMessages.isNotEmpty) {
    errorMessages.insert(
        0, 'Пожалуйста, исправьте ошибки в следующих модулях:\n\n');

    throw AnalyzerFailedException(errorMessages.join());
  }

  return true;
}

/// Проверяет изменились ли модули, отмеченные как stable.
/// Если есть изменённые — выбрасывает исключение со списком модулей.
Future<bool> checkStableModulesForChanges(List<Element> elements) async {
  final stableModules = elements.where((e) => e.isStable).toList();
  final changedModules = <Element>[];

  for (var stableModule in stableModules) {
    if (await CheckStableModuleForChanges(stableModule).run()) {
      changedModules.add(stableModule);
    }
  }

  if (changedModules.isNotEmpty) {
    final modulesNames = changedModules.map((e) => e.name).join(', ');
    return Future.error(
      StableModulesWasModifiedException(
          'Модули, отмеченные как stable, были изменены: $modulesNames'),
    );
  }

  return Future.value(true);
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
