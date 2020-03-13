import 'dart:io';

import 'package:init_project/domain/path_directory.dart';
import 'package:init_project/services/utils/print_message_console.dart';

/// Удаляет временную директорию, где загружен проект
class RemoveDirectoryTemp {
  Future<void> remove(PathDirectory _pathDirectory) async {
    printMessageConsole('clean...');
    if (_pathDirectory.pathTemp != null) {
      await Directory(_pathDirectory.pathTemp).delete(recursive: true);
    }
  }
}
