import 'dart:io';

import 'package:init_project/domain/command.dart';
import 'package:path/path.dart' as p;

const String urlGit = '';

/// Отвечает за загрузку проекта из git репозитория
class RepositoryManager {
  Future<void> run(Command command) async {
    var path = command.path;
    var nameProject = command.nameProject;
    try {
      var directory = await _createDirectory(path, nameProject);
    } catch (e) {
      rethrow;
    }
    return true;
  }

  /// Проверярка возможности создать директорию
  Future<Directory> _createDirectory(String path, String nameProject) async {
    try {
      var pathDirectory = path == null ? p.join(nameProject) : p.join(path, nameProject);
      return Directory(pathDirectory).create(recursive: true);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _loadTemplateProject(Directory directory, String name) async {
    ///
  }
}
