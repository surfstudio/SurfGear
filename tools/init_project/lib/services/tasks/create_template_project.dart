import 'package:init_project/domain/path_directory.dart';
import 'package:init_project/services/manager/message_console_manager.dart';
import 'package:io/io.dart';
import 'package:path/path.dart' as p;

/// Путь до папки с template
const String _pathPackagesTemplate = 'packages/template';

/// Создает шаблонный проект
class CreateTemplateProject {
  final ShowMessageManager _showMessageConsole;

  CreateTemplateProject(
    this._showMessageConsole,
  );

  Future<void> run(PathDirectory pathDirectory) async {
    try {
      await _copyTemplateFolder(pathDirectory);
      await _renameFile();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _copyTemplateFolder(PathDirectory pathDirectory) async {
    _showMessageConsole.printMessageConsole('copy project');
    var pathFolder = p.join(pathDirectory.pathTemp, _pathPackagesTemplate);
    await copyPath(pathFolder, pathDirectory.path);
  }

  Future<void> _renameFile() async {
    _showMessageConsole.printMessageConsole('rename file');
  }
}
