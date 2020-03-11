import 'dart:io';

import 'package:init_project/domain/command.dart';
import 'package:init_project/services/manager/message_console_manager.dart';
import 'package:path/path.dart' as p;

import 'package:shell/shell.dart';

const String _branchDev = 'dev';

/// Отвечает за загрузку проекта из git репозитория
class DownloadingRepository {
  final ShowMessageManager _showMessageConsole;
  Directory _pathDirectory;
  Directory _pathDirectoryTemp;

  DownloadingRepository(this._pathDirectoryTemp, this._showMessageConsole);

  Future<Directory> run(Command command) async {
    var path = command.path;
    var nameProject = command.nameProject;
    try {
      _pathDirectory = await _createDirectory(path, nameProject);
      await _loadTemplateProject(command.url);
//      await _switchBranch();
      return _pathDirectory;
    } catch (e) {
      rethrow;
    }
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

  Future<void> _loadTemplateProject(String url) async {

    _pathDirectoryTemp = await Directory(_pathDirectory.path).createTemp();

    _showMessageConsole.printMessageConsole('project download');
//    var processResult = await shell.run('git', ['clone', url, _pathDirectoryTemp.path, ]);
    var processResult = await shell.run('git', ['clone', url, _pathDirectoryTemp.path, '--depth', '1']);

    if (processResult.exitCode != 0) {
      return Future.error(processResult.stderr);
    }
//     processResult = await shell.run('cd', [ _pathDirectoryTemp.path]);
  }
  var shell = Shell();
//git checkout
//  Future<void> _switchBranch() async {
//
//    var processResult = await shell.run('git', ['checkout', _branchDev]);
//    if (processResult.exitCode != 0) {
//      return Future.error(processResult.stderr);
//    }
//  }
}
