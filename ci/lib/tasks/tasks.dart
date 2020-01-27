import 'dart:io';

import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/services/managers/file_system_manager.dart';
import 'package:ci/services/managers/license_manager.dart';
import 'package:ci/tasks/impl/license/add_copyright_task.dart';
import 'package:ci/tasks/impl/license/add_license_task.dart';
import 'package:ci/tasks/impl/license/license_file_check.dart';
import 'package:ci/tasks/package_builder_task.dart';

import 'impl/license/copyright_check.dart';

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
        getPackageBuildExceptionText(failList.join(', ')),
      ),
    );
  }
}

/// Добавляет переданным модулям лицензии.
///
/// dart ci add_license elements
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
/// dart ci Add_copyrights elements
Future<void> AddCopyrights(
  List<Element> elements, {
  FileSystemManager fileSystemManager,
  LicenseManager licenseManager,
}) async {
  fileSystemManager ??= FileSystemManager();
  licenseManager ??= LicenseManager();

  var filesToCheck = <FileSystemEntity>[];

  elements.forEach((e) {
    filesToCheck
      ..addAll(fileSystemManager
          .getEntitiesInDirectory(e.path)
          .where(licenseManager.isNeedCopyright));
  });

  var needCopyright = <FileSystemEntity>[];
  var troublesList = <FileSystemEntity, Exception>{};

  for (var file in filesToCheck) {
    try {
      await CopyrightCheck(
        file.path,
        fileSystemManager,
        licenseManager,
      ).run();
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
      await AddCopyrightTask(
        file.path,
        licenseManager,
        fileSystemManager,
      ).run();
    } on Exception catch (e) {
      troublesList[file] = e;
    }
  }
  ;

  if (troublesList.isNotEmpty) {
    var errorString;

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
