import 'package:init_project/domain/command.dart';
import 'package:init_project/domain/path_directory.dart';
import 'package:init_project/tasks/create_template_project.dart';
import 'package:init_project/tasks/downloading_repository.dart';

/// Утилита для загрузки и создания проекта
class CommandRunner {
  final DownloadingRepository _downloadingRepository;
  final CreateTemplateProject _createTemplateProject;

  CommandRunner(
    this._downloadingRepository,
    this._createTemplateProject,
  );

  /// Запускает опцию на выполнение.
  Future<void> run(Command command, PathDirectory pathDirectory) async {
    try {
      await _downloadingRepository.run(command, pathDirectory);
      await _createTemplateProject.run(command, pathDirectory);
    } catch (e) {
      rethrow;
    }
  }
}
