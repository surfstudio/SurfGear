import 'dart:io';

import 'package:init_project/domain/command.dart';
import 'package:init_project/domain/path_directory.dart';
import 'package:init_project/services/manager/message_console_manager.dart';
import 'package:path/path.dart' as p;

import 'package:shell/shell.dart';

/// Отвечает за загрузку проекта из git репозитория
class DownloadingRepository {
  final ShowMessageManager _showMessageConsole;

  DownloadingRepository(this._showMessageConsole);

  Future<PathDirectory> run(Command command, PathDirectory pathDirectory) async {
    var path = command.path;
    var nameProject = command.nameProject;
    try {
      await _createDirectory(path, nameProject, pathDirectory);
      await _loadTemplateProject(command.url, pathDirectory);
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

  Future<void> _loadTemplateProject(String url, PathDirectory pathDirectory) async {
    var shell = Shell();
    var directory = await Directory(pathDirectory.path).parent.createTemp();
    pathDirectory.pathTemp = directory.path;

    _showMessageConsole.printMessageConsole('Project download...');
    var processResult = await shell.run('git', ['clone', url, pathDirectory.pathTemp, '--depth', '1']);

    if (processResult.exitCode != 0) {
      return Future.error(processResult.stderr);
    }
  }
}
