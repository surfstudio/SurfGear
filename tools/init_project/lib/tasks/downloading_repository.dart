import 'dart:io';

import 'package:init_project/domain/command.dart';
import 'package:init_project/domain/path_directory.dart';
import 'package:init_project/services/utils/print_message_console.dart';
import 'package:path/path.dart' as p;

import 'package:shell/shell.dart';

/// Отвечает за загрузку проекта из git репозитория
class DownloadingRepository {
  Future<PathDirectory> run(Command command, PathDirectory pathDirectory) async {
    final path = command.path;
    final nameProject = command.nameProject;
    try {
      await _createDirectory(path, nameProject, pathDirectory);
      await _loadTemplateProject(command.remoteUrl, pathDirectory);
      return pathDirectory;
    } catch (e) {
      rethrow;
    }
  }

  /// Проверярка возможности создать директорию
  Future<void> _createDirectory(String path, String nameProject, PathDirectory pathDirectory) async {
    try {
      pathDirectory.path = path == null ? p.join(nameProject) : p.join(path, nameProject);
      await Directory(pathDirectory.path).create(recursive: true);
    } catch (e) {
      rethrow;
    }
  }

  /// Загружаем из репозитория проект
  Future<void> _loadTemplateProject(String remoteUrl, PathDirectory pathDirectory) async {
    final shell = Shell();
    final directory = await Directory(pathDirectory.path).createTemp();
    pathDirectory.pathTemp = directory.path;

    printMessageConsole('Template download...');

    final processResult = await shell.run('git', [
      'clone',
      remoteUrl,
      pathDirectory.pathTemp,
      '--depth',
      '1',
    ]);

    if (processResult.exitCode != 0) {
      return Future.error(Exception(processResult.stderr));
    }
  }
}
