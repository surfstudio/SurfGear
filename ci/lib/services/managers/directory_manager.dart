import 'dart:io';

/// Менеджер работы с директориями.
///
/// Фактически является фасадом над дарт io в части директорий.
class DirectoryManager {
  /// Возвращает объект директории.
  Directory getDirectory(String path) => Directory(path);

  /// Возвращает объекты в директории.
  List<FileSystemEntity> getEntitiesInDirectory(String path,
          {bool recursive = false, bool followLinks = true}) =>
      Directory(path).listSync(recursive: recursive, followLinks: followLinks);

  /// Проверяет является переданный путь директорией
  bool isDirectory(String path) => FileSystemEntity.isDirectorySync(path);
}
