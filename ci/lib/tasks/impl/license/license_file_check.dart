import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/services/managers/file_system_manager.dart';
import 'package:ci/services/managers/license_manager.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:path/path.dart';

/// Задача проверки файла лицензии.
///
/// Проверяет что файл в модуле есть и находится в актуальном состоянии.
/// По факту возвращает true или бросает исключения в соответствии с причиной.
class LicenseFileCheck extends Check {
  final Element _element;

  final LicenseManager _licenseManager;
  final FileSystemManager _fileSystemManager;

  LicenseFileCheck(
    this._element,
    this._licenseManager,
    this._fileSystemManager,
  );

  @override
  Future<bool> run() async {
    var licensePath = join(_element.path, _licenseManager.licenseFileName);
    var isExist = _fileSystemManager.isExist(licensePath);

    if (!isExist) {
      return Future.error(
        LicenseFileNotFoundException(
          getLicenseFileNotFoundExceptionText(licensePath),
        ),
      );
    } else {
      var sample;
      try {
        sample = await _licenseManager.getLicense();
      } on LicenseSampleNotFoundException catch (e) {
        return Future.error(e);
      }

      /// проверяем актуальность файла
      var content = _fileSystemManager.readFileAsString(licensePath);

      if (content != sample) {
        return Future.error(
          LicenseFileObsoleteException(
            getLicenseFileObsoleteExceptionText(licensePath),
          ),
        );
      }
    }

    return true;
  }
}
