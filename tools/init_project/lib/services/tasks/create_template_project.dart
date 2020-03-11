import 'dart:io';

import 'package:init_project/domain/path_directory.dart';
import 'package:init_project/services/manager/message_console_manager.dart';
import 'package:io/io.dart';
import 'package:path/path.dart' as p;

/// Путь до папки с template
const String _pathPackagesTemplate = 'packages/template';
const String _fileName = '.dart';
RegExp _expDependency = RegExp('template');

/// Создает шаблонный проект
class CreateTemplateProject {
  final ShowMessageManager _showMessageConsole;

  CreateTemplateProject(
    this._showMessageConsole,
  );

  Future<void> run(PathDirectory pathDirectory) async {
    try {
      await _copyTemplateFolder(pathDirectory);
      await _renameFile(pathDirectory);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _copyTemplateFolder(PathDirectory pathDirectory) async {
    _showMessageConsole.printMessageConsole('copy project');
    var pathFolder = p.join(pathDirectory.pathTemp, _pathPackagesTemplate);
    await copyPath(pathFolder, pathDirectory.path);
  }

  Future<void> _renameFile(PathDirectory pathDirectory) async {
    var dir = Directory(pathDirectory.path);
    _showMessageConsole.printMessageConsole('rename file');
    await dir.list(recursive: true, followLinks: false).listen((FileSystemEntity entity) async {
      String fileName = p.basename(entity.path);

      if (await FileSystemEntity.isFile(entity.path)) {
        if (fileName.contains(_fileName)) {
          var tempFile = File(entity.path);
          List<String> r = tempFile.readAsLinesSync();
          for (var _r in r){
            _r.replaceAllMapped(_expDependency,( replace){
              return '"${replace.group(0)}"';
            });
          }
//          print(r);
        }
      }
    });

//    final string = '{name : aName, hobby : [fishing, playing_guitar]}';
//    final newString = string.replaceAllMapped(RegExp(r'\b\w+\b'), (match) {
//      return '"${match.group(0)}"';
//    });
//    print(newString);
  }
}
