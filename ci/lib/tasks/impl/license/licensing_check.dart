import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/services/managers/file_system_manager.dart';
import 'package:ci/services/managers/license_manager.dart';
import 'package:ci/tasks/impl/license/copyright_check.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:ci/tasks/impl/license/license_file_check.dart';

/// Выполняет проверку лицензии в модуле и копирайтов у файлов.
class LicensingCheck extends Check {
  final Element _package;
  final List<String> _troubles = <String>[];

  final LicenseManager _licenseManager;
  final FileSystemManager _fileSystemManager;

  LicensingCheck(
    this._package,
    this._licenseManager,
    this._fileSystemManager,
  );

  @override
  Future<bool> run() async {
    return await _check(_package);
  }

  Future<bool> _check(Element package) async {
    await _checkLicenseFile(package);
    await _checkCopyrights(package);

    if (_troubles.isNotEmpty) {
      return Future.error(
        PackageLicensingException(
          'Модуль ${_package.name} имеет проблемы с лицензированием:\n${_troubles.join("\n")}',
        ),
      );
    }

    return true;
  }

  Future<void> _checkLicenseFile(Element package) async {
    try {
      await LicenseFileCheck(
        package,
        _licenseManager,
        _fileSystemManager,
      ).run();
    } on BaseCiException catch (e) {
      _troubles.add(e.message);
    }
  }

  Future<void> _checkCopyrights(Element package) async {
    var copyrightOwners = _fileSystemManager
        .getEntitiesInDirectory(package.path)
        .where(_licenseManager.isNeedCopyright)
        .toList();

    for (var file in copyrightOwners) {
      try {
        await CopyrightCheck(
          file.path,
          _fileSystemManager,
          _licenseManager,
        ).run();
      } on BaseCiException catch (e) {
        _troubles.add(e.message);
      }
    }
  }
}
