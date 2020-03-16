import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/services/managers/file_system_manager.dart';
import 'package:ci/services/managers/license_manager.dart';
import 'package:ci/tasks/core/task.dart';

/// Добавляет копирайт в указанный файл.
///
/// Данная задача исключительно добавляет в файл заголовок копирайта.
/// Она не проверяет его наличие и актуальность,
/// не производит обновление старого копирайта.
/// Используйте соответствующие таски при необходимости.
class AddCopyrightTask extends Action {
  final String _filePath;

  final LicenseManager _licenseManager;
  final FileSystemManager _fileSystemManager;

  AddCopyrightTask(this._filePath, this._licenseManager, this._fileSystemManager);

  @override
  Future<void> run() async {
    var isExist = _fileSystemManager.isExist(_filePath);

    if (!isExist) {
      return Future.error(
        FileNotFoundException(
          'File $_filePath not found',
        ),
      );
    }

    String copyright;
    try {
      copyright = await _licenseManager.getCopyright();
    } on CopyrightSampleNotFoundException catch (e) {
      return Future.error(e);
    }

    var content = _fileSystemManager.readFileAsString(_filePath);
    content = copyright + content;

    _fileSystemManager.writeToFileAsString(_filePath, content);
  }
}
