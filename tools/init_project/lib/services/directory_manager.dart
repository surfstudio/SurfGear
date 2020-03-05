import 'package:init_project/domain/command.dart';

class DirectoryManager {
  Future<void> createDirectory(Command command) async {
    try {
      await _checkDirectory(command.path);
    } catch (e) {
      rethrow;
    }
    return true;
  }

  /// Проверярка возможности создать директорию
  Future<void> _checkDirectory(String path) async {}

  Future<void> _create(String path, String name) async {}
}
