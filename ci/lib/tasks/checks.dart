import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/services/managers/file_system_manager.dart';
import 'package:ci/services/managers/license_manager.dart';
import 'package:ci/services/runner/shell_runner.dart';
import 'package:ci/tasks/impl/license/licensing_check.dart';

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

/// Проверка лицензирования переданных пакетов.
///
/// Проверяется наличие лицензии и её актуальность а так же наличие
/// и правильность копирайтов у файлов.
///
/// dart ci check_licensing elements
Future<void> checkLicensing(List<Element> elements) async {
  var failList = <Element, Exception>{};

  for (var element in elements) {
    var licenseCheck =
        LicensingCheck(element, LicenseManager(), FileSystemManager());
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
}
