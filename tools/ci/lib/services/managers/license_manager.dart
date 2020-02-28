import 'dart:io';

import 'package:ci/domain/config.dart';
import 'package:ci/exceptions/exceptions.dart';

/// Менеджер для работы с лицензиями.
class LicenseManager {
  static const List<String> _filesWithCopyright = <String>['.dart'];
  static const String _licenseFileName = 'LICENSE';

  /// Имя файла лицензии для модуля.
  String get licenseFileName => _licenseFileName;

  /// Возвращает образец лицензии
  Future<String> getLicense() async{
    var licensePath = Config.licenseFilePath;
    var license = File(licensePath);

    if (await license.exists()) {
      return license.readAsString();
    } else {
      return Future.error(LicenseSampleNotFoundException());
    }
  }

  /// Возвращает образец копирайта
  Future<String> getCopyright() async{
    var path = Config.copyrightFilePath;
    var copyright = File(path);

    if (await copyright.exists()) {
      return copyright.readAsString();
    } else {
      return Future.error(CopyrightSampleNotFoundException());
    }
  }

  /// Возвращает нужен ли файлу копирайт
  bool isNeedCopyright(FileSystemEntity entity) {
    for (var pattern in _filesWithCopyright) {
      if (entity.path.contains(pattern)) {
        return true;
      }
    }

    return false;
  }
}