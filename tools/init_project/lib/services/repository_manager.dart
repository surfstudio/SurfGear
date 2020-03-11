import 'dart:io';

import 'package:init_project/domain/command.dart';
import 'package:path/path.dart' as p;

//import 'package:process_run/shell_run.dart';
import 'package:shell/shell.dart';

//const String urlGit = '';

/// Отвечает за загрузку проекта из git репозитория
class RepositoryManager {
  Future<void> run(Command command) async {
//    var path = command.path;
//    var nameProject = command.nameProject;
    try {
//      var directory = await _createDirectory(path, nameProject);
      await _loadTemplateProject(command.path, command.nameProject, command.url);
    } catch (e) {
      rethrow;
    }
    return true;
  }

  /// Проверярка возможности создать директорию
//  Future<Directory> _createDirectory(String path, String nameProject) async {
//    try {
//      var pathDirectory = path == null ? p.join(nameProject) : p.join(path, nameProject);
//      return Directory(pathDirectory).create(recursive: true);
//    } catch (e) {
//      rethrow;
//    }
//  }

  Future<void> _loadTemplateProject(String path, String nameProject, String url) async {
    path ??= p.current;
    var str = p.join(path, nameProject);
    Shell shell = Shell();

    print(str);

    var processResult = await shell.run('git', ['clone', url, str, '--depth', '1']);
    if (processResult.exitCode!=0){
      return Future.error(processResult.stderr);
    }
  }
}
