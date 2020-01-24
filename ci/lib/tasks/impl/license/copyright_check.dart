import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/services/managers/file_system_manager.dart';
import 'package:ci/services/managers/license_manager.dart';
import 'package:ci/tasks/core/task.dart';

/// Выполняет проверку на наличие и актуальность копирайта у файла.
///
/// Возвращает true или бросает соответствующее искоючение.
class CopyrightCheck extends Check {
  static const String _copyrightTag = 'Copyright (c)';
  final String _filePath;

  final FileSystemManager _fileSystemManager;
  final LicenseManager _licenseManager;

  CopyrightCheck(
    this._filePath,
    this._fileSystemManager,
    this._licenseManager,
  );

  @override
  Future<bool> run() async {
    var isExist = _fileSystemManager.isExist(_filePath);

    if (!isExist) {
      return Future.error(
        FileNotFoundException(
          'File $_filePath not found',
        ),
      );
    }

    var sample;
    try {
      sample = await _licenseManager.getCopyright();
    } on CopyrightSampleNotFoundException catch (e) {
      return Future.error(e);
    }

    var content = _fileSystemManager.readFileAsString(_filePath);

    if (!content.contains(sample)) {
      if (content.contains(_copyrightTag)) {
        return Future.error(
          FileCopyrightObsoleteException(
            'Копирайт файла $_filePath устарел',
          ),
        );
      } else {
        return Future.error(
          FileCopyrightMissedException(
            'Копирайт файла $_filePath не найден',
          ),
        );
      }
    }

    return true;
  }
}
