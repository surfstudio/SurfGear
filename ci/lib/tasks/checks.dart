import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/services/managers/file_system_manager.dart';
import 'package:ci/services/managers/license_manager.dart';
import 'package:ci/services/pubspec_parser.dart';
import 'package:ci/tasks/check_dependency_stable.dart';
import 'package:ci/tasks/check_stability_dev.dart';
import 'package:ci/tasks/factories/license_task_factory.dart';
import 'package:ci/tasks/impl/license/copyright_check.dart';
import 'package:ci/tasks/impl/license/licensing_check.dart';
import 'package:ci/tasks/linter_check.dart';
import 'package:ci/tasks/pub_check_release_version_task.dart';
import 'package:ci/tasks/pub_dry_run_task.dart';
import 'package:ci/tasks/stable_modules_for_changes_check.dart';
import 'package:ci/tasks/utils.dart';

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

/// Проверка лицензирования переданных пакетов.
///
/// Проверяется наличие лицензии и её актуальность а так же наличие
/// и правильность копирайтов у файлов.
///
/// dart ci check_licensing elements
Future<bool> checkLicensing(List<Element> elements) async {
  var failList = <Element, Exception>{};

  for (var element in elements) {
    var licenseCheck = LicensingCheck(
      element,
      LicenseManager(),
      FileSystemManager(),
      LicenseTaskFactory(),
    );

    try {
      await licenseCheck.run();
    } on Exception catch (e) {
      failList[element] = e;
    }
  }

  if (failList.isNotEmpty) {
    var errorString;

    failList.forEach((key, value) {
      errorString += key.name + ':\n';
      errorString += value.toString() + '\n';
    });

    return Future.error(
      PackageLicensingException(
        getPackageLicensingExceptionText(errorString),
      ),
    );
  }

  return true;
}

/// Проверяет копирайт файла.
Future<bool> checkCopyright(
  String filePath,
  FileSystemManager fileSystemManager,
  LicenseManager licenseManager,
) async =>
    CopyrightCheck(
      filePath,
      fileSystemManager,
      licenseManager,
    ).run();


/// Проверяет, что модули не стали стабильными от изменений в dev ветке.
Future<bool> checkStabilityNotChangeInDev(List<Element> elements) async {
  // у измененных элементов должен быть выставлен флаг
  elements = await findChangedElements(elements);

  return CheckStabilityDev(elements, PubspecParser()).run();
}