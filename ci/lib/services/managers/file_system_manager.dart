import 'dart:convert';
import 'dart:io';

/// Менеджер работы с файловой системой.
///
/// Фактически является фасадом над дарт io в части директорий и файлов.
class FileSystemManager {
  /// Проверяет является переданный путь директорией
  bool isDirectory(String path) => FileSystemEntity.isDirectorySync(path);

  /// Проверяет существует ли объект файловой системы по данному пути.
  ///
  /// Включает в себя файл, папку, линк.
  bool isExist(String path) =>
      FileSystemEntity.typeSync(path) != FileSystemEntityType.notFound;

  /// Возвращает объект директории.
  Directory getDirectory(String path) => Directory(path);

  /// Возвращает объекты в директории.
  List<FileSystemEntity> getEntitiesInDirectory(String path,
          {bool recursive = false, bool followLinks = true}) =>
      Directory(path).listSync(recursive: recursive, followLinks: followLinks);

  /// Возвращает значение файла в виде строки.
  String readFileAsString(
    String path, {
    Encoding encoding = utf8,
  }) =>
      File(path).readAsStringSync(encoding: encoding);

  /// Записывает в файл строковые данные.
  void writeToFileAsString(String path, String contents,
          {FileMode mode = FileMode.write,
          Encoding encoding = utf8,
          bool flush = false}) =>
      File(path).writeAsString(contents,
          mode: mode, encoding: encoding, flush: flush);
}
