import 'dart:io';

import 'package:ci/domain/element.dart';
import 'package:ci/domain/tag.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/services/managers/file_system_manager.dart';
import 'package:ci/services/managers/license_manager.dart';
import 'package:ci/services/managers/yaml_manager.dart';
import 'package:ci/services/pub_publish_manager.dart';
import 'package:ci/tasks/checks.dart';
import 'package:ci/tasks/impl/building/increment_dev_version_task.dart';
import 'package:ci/tasks/impl/building/package_builder_task.dart';
import 'package:ci/tasks/impl/building/update_versions_depending_on_module_task.dart';
import 'package:ci/tasks/impl/git/fix_changes_task.dart';
import 'package:ci/tasks/impl/license/add_copyright_task.dart';
import 'package:ci/tasks/impl/license/add_license_task.dart';
import 'package:ci/tasks/impl/license/license_file_check.dart';
import 'package:ci/tasks/impl/project/add_project_tag_task.dart';
import 'package:ci/tasks/impl/project/update_dependencies_by_tag_task.dart';
import 'package:ci/tasks/mirror_module_task.dart';
import 'package:ci/tasks/save_element_task.dart';
import 'package:ci/tasks/utils.dart';

import 'impl/publish/pub_publish_module_task.dart';

/// Набор глобальных точек входа для выполнения задач

/// Выполняет сборку переданных модулей.
Future<void> build(List<Element> elements) async {
  // TODO: проверки на изменение? или получаем сразу проверенный список, стоит подумать и решить

  var failList = <Element>[];
  for (var element in elements) {
    var buildTask = PackageBuilderTask(element, FileSystemManager());
    try {
      await buildTask.run();
    } on PackageBuildException {
      failList.add(element);
    }
  }

  if (failList.isNotEmpty) {
    return Future.error(
      PackageBuildException(
        getPackageBuildExceptionText(failList.map((e) => e.name).join(', ')),
      ),
    );
  }
}

/// Добавляет переданным модулям лицензии.
///
/// dart ci add_license
Future<void> addLicense(List<Element> elements) async {
  var needUpdate = <Element>[];

  for (var element in elements) {
    var checkTask = LicenseFileCheck(
      element,
      LicenseManager(),
      FileSystemManager(),
    );
    try {
      await checkTask.run();
    } on BaseCiException {
      needUpdate.add(element);
    }

    var failList = <Element>[];

    for (var update in needUpdate) {
      var updateTask = AddLicenseTask(
        update,
        LicenseManager(),
        FileSystemManager(),
      );
      try {
        await updateTask.run();
      } on BaseCiException {
        failList.add(element);
      }
    }

    if (failList.isNotEmpty) {
      return Future.error(
        AddLicenseFailException(
          getAddLicenseFailExceptionText(failList.join(', ')),
        ),
      );
    }
  }
}

/// Добавляет переданным модулям копирайты в файлы.
///
/// dart ci add_copyrights
Future<void> addCopyrights(
  List<Element> elements, {
  FileSystemManager fileSystemManager,
  LicenseManager licenseManager,
}) async {
  fileSystemManager ??= FileSystemManager();
  licenseManager ??= LicenseManager();

  var filesToCheck = <FileSystemEntity>[];

  elements.forEach(
    (element) {
      List<FileSystemEntity> list = fileSystemManager.getEntitiesInModule(
        element,
        recursive: true,
        filter: licenseManager.isNeedCopyright,
      );
      filesToCheck.addAll(list);
    },
  );

  var needCopyright = <FileSystemEntity>[];
  var troublesList = <FileSystemEntity, Exception>{};

  for (var file in filesToCheck) {
    try {
      await checkCopyright(
        file.path,
        fileSystemManager,
        licenseManager,
      );
    } on FileCopyrightMissedException catch (_) {
      needCopyright.add(file);
    } on FileCopyrightObsoleteException catch (e) {
      // TODO: подумать насколько критично
      troublesList[file] = e;
    } on Exception catch (e) {
      troublesList[file] = e;
    }
  }

  for (var file in needCopyright) {
    try {
      await addCopyright(
        file.path,
        fileSystemManager,
        licenseManager,
      );
    } on Exception catch (e) {
      troublesList[file] = e;
    }
  }

  if (troublesList.isNotEmpty) {
    var errorString = '';

    troublesList.forEach((key, value) {
      errorString += key.path + ':\n';
      errorString += value.toString() + '\n';
    });

    return Future.error(
      AddCopyrightFailException(
        getAddCopyrightFailExceptionText(errorString),
      ),
    );
  }
}

/// Добавляет копирайт файлу.
Future<void> addCopyright(
  String path,
  FileSystemManager fileSystemManager,
  LicenseManager licenseManager,
) =>
    AddCopyrightTask(
      path,
      licenseManager,
      fileSystemManager,
    ).run();

/// Пушит open source модули в отдельные репозитории
Future<void> mirrorOpenSourceModules(
  List<Element> elements,
  String currentBranch,
) async {
  final hasRepo = (Element e) => e.openSourceInfo?.separateRepoUrl != null;
  final openSourceModules = elements.where(hasRepo).toList();
  var failedModulesNames = <String>[];

  openSourceModules.forEach(
    (element) {
      print(
          'Mirror package ${element.name} to ${element.openSourceInfo.separateRepoUrl}');
      try {
        return MirrorOpenSourceModuleTask(element, currentBranch).run();
      } on ModuleMirroringException catch (exception) {
        print('Package ${element.name} mirroring error !!!');
        print(exception.message);
        failedModulesNames.add(element.name);
      } catch (exception) {
        print('Package ${element.name} mirroring error !!!');
        print(exception.toString());
        failedModulesNames.add(element.name);
        rethrow;
      }
    },
  );

  if (failedModulesNames.isNotEmpty) {
    print('Modules were not mirrored: ${failedModulesNames.join(',')}');
  }
}

/// Обновляет зависимости переданных модулей по данным тега.
Future<List<Element>> updateDependenciesByTag(
  List<Element> list,
  ProjectTag tag,
) async {
  var updatedList = <Element>[];

  for (var element in list) {
    var newElement = await UpdateDependenciesByTagTask(
      element,
      tag,
    ).run();

    updatedList.add(newElement);
  }

  return updatedList;
}

/// Добавляет переданный тег к текущему состоянию
Future<void> addTag(ProjectTag tag) => AddProjectTagTask(tag).run();

/// Сохраняет переданные представления модулей.
Future<void> saveElements(
  List<Element> list, {
  FileSystemManager fileSystemManager,
  YamlManager yamlManager,
}) async {
  fileSystemManager ??= FileSystemManager();
  yamlManager ??= YamlManager();

  for (var element in list) {
    await SaveElementTask(
      element,
      fileSystemManager,
      yamlManager,
    ).run();
  }
}

/// Фиксирует текущие изменения на репозитории.
Future<void> fixChanges({String message}) => FixChangesTask(
      message: message,
    ).run();

/// Публикуем модули
/// [pathServer] принимать адрес сервера куда паблишить, необзательный параметр
Future<void> pubPublishModules(Element element, {String pathServer}) =>
    PubPublishModuleTask(
      element,
      PubPublishManager(),
      pathServer: pathServer,
    ).run();

/// Инкриминирует версию у зависимых от элемнета элементов рукурсивно
Future<void> updateVersionsDependingOnModule(
  List<Element> allElements, {
  List<Element> incrementElements = const [],
}) async {
  /// toSet чтобы избавиться от дубликатов в зависимых элементах
  List<Element> dependents =
      (await findDependentByChangedElements(allElements)).toSet().toList();

  /// Удаляем уже ранее инкрементированые элементы
  dependents = dependents.where(
    (Element element) {
      for (var inc in incrementElements) {
        if (inc.name == element.name) {
          return false;
        }
      }
      return true;
    },
  ).toList();

  if (dependents.isNotEmpty) {
    for (var i = 0; dependents.length > i; i++) {
      dependents[i] = await IncrementDevVersionTask(dependents[i]).run();
    }

    dependents =
        await UpdateVersionsDependingOnModuleTask(allElements, dependents)
            .run();

    await saveElements(dependents);
    updateVersionsDependingOnModule(
      allElements,
      incrementElements: dependents,
    );
  }
}
