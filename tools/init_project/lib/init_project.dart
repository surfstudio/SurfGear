import 'package:init_project/services/tasks/check_install_git.dart';
import 'package:init_project/services/parcer/command_parser.dart';
import 'package:init_project/services/command_runner.dart';
import 'package:init_project/services/tasks/create_template_project.dart';
import 'package:init_project/services/tasks/remove_directory_temp.dart';
import 'package:init_project/services/tasks/downloading_repository.dart';
import 'dart:io';

import 'package:init_project/services/manager/message_console_manager.dart';

class InitProject {
  static InitProject _instance;

  /// Временная директория для скачанного проекта, должна удаляться после завершения работы
  static Directory _pathDirectoryTemp;

  static InitProject get instance => _instance ??= InitProject._();
  static final ShowMessageManager _showMessageConsole = ShowMessageManager();

  CommandParser _commandParser;
  CommandRunner _commandRunner;
  RemoveDirectoryTemp _removeDirectoryTemp;
  CheckInstallGit _checkInstallGit;

  InitProject._({
    CommandParser commandParser,
    CommandRunner commandRunner,
    CheckInstallGit checkInstallGit,
    RemoveDirectoryTemp removeDirectoryTemp,
    ShowMessageManager showMessageConsole,
    CreateTemplateProject createTemplateProject,
  })  : _commandParser = commandParser ?? CommandParser(),
        _commandRunner = commandRunner ??
            CommandRunner(
              DownloadingRepository(_pathDirectoryTemp, _showMessageConsole),
              CreateTemplateProject(_pathDirectoryTemp, _showMessageConsole),
            ),
        _checkInstallGit = checkInstallGit ?? CheckInstallGit(),
        _removeDirectoryTemp =
            removeDirectoryTemp ?? RemoveDirectoryTemp(_pathDirectoryTemp, _showMessageConsole);

  InitProject.init({
    CommandParser commandParser,
    CommandRunner commandRunner,
    CheckInstallGit checkInstallGit,
    RemoveDirectoryTemp removeDirectoryTemp,
    CreateTemplateProject createTemplateProject,
  }) {
    _instance ??= InitProject._(
      commandParser: commandParser,
      commandRunner: commandRunner,
      checkInstallGit: checkInstallGit,
      createTemplateProject: createTemplateProject,
    );
  }

  /// TODO:  тут нужно добавить удаление скачанного репозитория [RemoveDirectoryTemp]
  Future<void> execute(List<String> arguments) async {
    try {
      await _checkInstallGit.check();
      var command = await _commandParser.parser(arguments);
      if (command != null) {
        await _commandRunner.run(command);
      }
    } catch (e) {
      rethrow;
    } finally {
      try {
        await _removeDirectoryTemp.remove();
      } catch (e) {
        rethrow;
      }
    }
  }
}
