import 'package:dio/dio.dart';

/// Менеджер для проверки версии пакета.
class VersionManager {
  static VersionManager _instance;
  static const _api = 'https://pub.dartlang.org/api/packages/';
  final Dio dio = Dio();

  factory VersionManager() {
    return _instance ??= VersionManager._();
  }

  VersionManager._();

  /// Проверяет обновилась ли локальная версия
  Future<bool> checkIsNewVersion<T>(String name, String version) async {
    try {
      var response = await dio.get('$_api$name');
      return response.data['latest']['pubspec']['version'] != version;
    } catch (e) {
      return true;
    }
  }
}
