import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/services/managers/file_system_manager.dart';
import 'package:ci/services/managers/license_manager.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:path/path.dart';

/// Добавляет файл лицензии в переданный модуль.
class AddLicenseTask extends Action {
  final Element _element;

  final LicenseManager _licenseManager;
  final FileSystemManager _fileSystemManager;

  AddLicenseTask(this._element, this._licenseManager, this._fileSystemManager);

  @override
  Future<void> run() async {
    var license;
    try {
      license = await _licenseManager.getLicense();
    } on LicenseSampleNotFoundException catch (e) {
      return Future.error(e);
    }

    var licensePath = join(_element.path, _licenseManager.licenseFileName);

    _fileSystemManager.writeToFileAsString(licensePath, license);
  }
}
