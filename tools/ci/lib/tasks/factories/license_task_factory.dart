import 'package:ci/domain/element.dart';
import 'package:ci/services/managers/file_system_manager.dart';
import 'package:ci/services/managers/license_manager.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:ci/tasks/impl/license/copyright_check.dart';
import 'package:ci/tasks/impl/license/license_file_check.dart';

/// Фабрика задач работы с лиценизиями.
class LicenseTaskFactory {
  /// Создает задачу проверки файла лицензии.
  Task<bool> createLicenseFileCheck(
    Element element,
    LicenseManager licenseManager,
    FileSystemManager fileSystemManager,
  ) =>
      LicenseFileCheck(
        element,
        licenseManager,
        fileSystemManager,
      );

  /// Создает задачу проверки наличия и актуальность копирайта у файла.
  Task<bool> createCopyrightCheck(
    String filePath,
    FileSystemManager fileSystemManager,
    LicenseManager licenseManager,
  ) =>
      CopyrightCheck(
        filePath,
        fileSystemManager,
        licenseManager,
      );
}
