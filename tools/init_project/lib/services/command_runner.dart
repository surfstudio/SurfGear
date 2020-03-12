import 'package:init_project/domain/command.dart';
import 'package:init_project/domain/path_directory.dart';
import 'package:init_project/services/tasks/create_template_project.dart';
import 'package:init_project/services/tasks/downloading_repository.dart';

class CommandRunner {
  final DownloadingRepository _directoryManager;
  final CreateTemplateProject _createTemplateProject;

  CommandRunner(
    this._directoryManager,
    this._createTemplateProject,
  );

  Future<void> run(Command command, PathDirectory pathDirectory) async {
    try {
      await _directoryManager.run(command, pathDirectory);
      _createTemplateProject.run(command, pathDirectory);
    } catch (e) {
      rethrow;
    }
  }
}
