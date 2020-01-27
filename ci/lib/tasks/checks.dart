import 'dart:io';

import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/services/runner/shell_runner.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:ci/tasks/pub_check_release_version_task.dart';
import 'package:ci/tasks/pub_dry_run_task.dart';

/// Проверяет изменились ли модули, отмеченные как stable.
/// Если есть изменённые — выбрасывает исключение со списком модулей.
class CheckStableModulesForChanges implements Check {
  final List<Element> elements;

  CheckStableModulesForChanges(this.elements);

  @override
  Future<bool> run() {
    final changedModules =
        elements.where((e) => e.isStable && e.changed).toList();

    if (changedModules.isNotEmpty) {
      final modulesNames = changedModules.map((e) => e.name).join(', ');
      return Future.error(
        StableModulesWasModifiedException(
            'Модули, отмеченные как stable, были изменены: $modulesNames'),
      );
    }

    return Future.value(true);
  }
}

/// Проверка модулей с помощью `flutter analyze`.
class CheckModulesWithLinter implements Check {
  final List<Element> elements;

  CheckModulesWithLinter(this.elements);

  @override
  Future<bool> run() async {
    var errorMessages = <String>[];

    for (var element in elements) {
      final analyzeResult = await sh(
        'flutter analyze',
        path: element.uri.toFilePath(windows: Platform.isWindows),
      );

      if (analyzeResult.exitCode != 0) {
        final errorMessage =
            '${analyzeResult.stdout}${analyzeResult.stderr}\n\n';
        errorMessages.add(errorMessage);
      }
    }

    if (errorMessages.isNotEmpty) {
      errorMessages.insert(
          0, 'Пожалуйста, исправьте ошибки в следующих модулях:\n\n');

      return Future.error(
        AnalyzerFailedException(errorMessages.join()),
      );
    }

    return true;
  }
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
Future<bool> checkPubCheckReleaseVersionTask(Element element) {
  return PubCheckReleaseVersionTask(element).run();
}
