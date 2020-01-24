import 'dart:io';

import 'package:path/path.dart';

/// Конфигурация приложения
/// TODO: заполнение и парсинг не из кодового представления
class Config {
  static final String _resourcesPath = join(
    Directory.current.parent.path,
    'resources',
  );
  static final String _licensePath = join(
    _resourcesPath,
    'license',
  );


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
}
