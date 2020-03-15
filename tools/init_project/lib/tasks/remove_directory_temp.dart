import 'dart:io';

import 'package:init_project/domain/path_directory.dart';
import 'package:init_project/services/utils/print_message_console.dart';

/// Удаляет временную директорию с скаченным проектом template
class RemoveDirectoryTemp {
  Future<void> remove(PathDirectory _pathDirectory) async {
    if (_pathDirectory.pathTemp != null) {
      printMessageConsole('Directory cleaning...');
      await Directory(_pathDirectory.pathTemp).delete(recursive: true);
    }
  }
}
