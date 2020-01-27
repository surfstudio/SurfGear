import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/services/factories/license_task_factory.dart';
import 'package:ci/services/managers/file_system_manager.dart';
import 'package:ci/services/managers/license_manager.dart';
import 'package:ci/tasks/core/task.dart';

/// Выполняет проверку лицензии в модуле и копирайтов у файлов.
class LicensingCheck extends Check {
  final Element _package;

  final LicenseManager _licenseManager;
  final FileSystemManager _fileSystemManager;
  final LicenseTaskFactory _licenseTaskFactory;

  LicensingCheck(
    this._package,
    this._licenseManager,
    this._fileSystemManager,
    this._licenseTaskFactory,
  );

  @override
  Future<bool> run() async {
    return _check(_package);
  }

  Future<bool> _check(Element package) async {
    var troubles = <String>[];

    try {
      await _licenseTaskFactory
          .createLicenseFileCheck(
            package,
            _licenseManager,
            _fileSystemManager,
          )
          .run();
    } on BaseCiException catch (e) {
      troubles.add(e.message);
    }

    var copyrightOwners = _fileSystemManager
        .getEntitiesInDirectory(package.path)
        .where(_licenseManager.isNeedCopyright)
        .toList();

    for (var file in copyrightOwners) {
      try {
        await _licenseTaskFactory
            .createCopyrightCheck(
              file.path,
              _fileSystemManager,
              _licenseManager,
            )
            .run();
      } on BaseCiException catch (e) {
        troubles.add(e.message);
      }
    }

    if (troubles.isNotEmpty) {
      return Future.error(
        PackageLicensingException(
          'Модуль ${_package.name} имеет проблемы с лицензированием:\n${troubles.join("\n")}',
        ),
      );
    }

    return true;
  }
}
