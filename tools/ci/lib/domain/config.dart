import 'dart:io';

import 'package:path/path.dart';

/// Конфигурация приложения
///
/// Данный конфиг позволяет уйти на уровень абстракции от
/// конкретного указания параметров, путей, etc в коде.
/// TODO: заполнение и парсинг не из кодового представления
abstract class Config {
  static final String _resourcesPath = join(
    Directory.current.path,
    'tools',
    'ci',
    'lib',
    'resources',
  );

  static final String _licensePath = join(
    _resourcesPath,
    'license',
  );

  static final String _standardPath = Directory.current.path;

  /// Путь до файла с лицензией
  static final String licenseFilePath = join(
    _licensePath,
    'LICENSE',
  );

  /// Путь до файла с лицензией
  static final String copyrightFilePath = join(
    _licensePath,
    'copyright',
  );

  /// Путь до директории с модулями
  static final String packagesPath = join(
    _standardPath,
    'packages',
  );

  /// Путь до директории с модулями
  static final String releaseNoteFilePath = join(
    _standardPath,
    'RELEASE_NOTES.md',
  );

  /// Путь до toplevel-директории гит-репозитория
  static final String repoRootPath = _standardPath;
}
