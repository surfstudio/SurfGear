import 'package:dio/dio.dart';

/// Manager to check the package version
class VersionManager {
  static VersionManager _instance;
  static const _api = 'https://pub.dartlang.org/api/packages/';
  final Dio dio = Dio();

  factory VersionManager() {
    return _instance ??= VersionManager._();
  }

  VersionManager._();

  /// Checks if the local version has been updated
  Future<bool> checkIsNewVersion<T>(String name, String version) async {
    try {
      var response = await dio.get('$_api$name');
      return response.data['latest']['pubspec']['version'] != version;
    } catch (e) {
      return true;
    }
  }
}
