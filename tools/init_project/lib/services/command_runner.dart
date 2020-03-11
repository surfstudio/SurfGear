import 'dart:io';

import 'package:init_project/domain/command.dart';
import 'package:init_project/services/tasks/downloading_repository.dart';
import 'package:init_project/services/tasks/create_template_project.dart';

class CommandRunner {
  final DownloadingRepository _directoryManager;
  final CreateTemplateProject _createTemplateProject;

  CommandRunner(
    this._directoryManager,
    this._createTemplateProject,
  );

  Future<void> run(Command command) async {
    try {
      var pathDirectory = await _directoryManager.run(command);
      _createTemplateProject.run(pathDirectory);
    } catch (e) {
      rethrow;
    }
  }
}
