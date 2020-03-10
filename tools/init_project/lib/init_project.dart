import 'package:init_project/services/check_install_git.dart';
import 'package:init_project/services/command_parser.dart';
import 'package:init_project/services/command_runner.dart';
import 'package:init_project/services/repository_manager.dart';

class InitProject {
  static InitProject _instance;

  static InitProject get instance => _instance ??= InitProject._();
  CommandParser _commandParser;

  CommandRunner _commandRunner;

  CheckInstallGit _checkInstallGit;

  InitProject._({
    CommandParser commandParser,
    CommandRunner commandRunner,
    CheckInstallGit checkInstallGit,
  })  : _commandParser = commandParser ?? CommandParser(),
        _commandRunner = commandRunner ?? CommandRunner(RepositoryManager()),
        _checkInstallGit = checkInstallGit ?? CheckInstallGit();

  InitProject.init({
    CommandParser commandParser,
    CommandRunner commandRunner,
    CheckInstallGit checkInstallGit,
  }) {
    _instance ??= InitProject._(
      commandParser: commandParser,
      commandRunner: commandRunner,
      checkInstallGit: checkInstallGit,
    );
  }

  Future<void> execute(List<String> arguments) async {
    try {
      await _checkInstallGit.check();
      var command = await _commandParser.parser(arguments);
      if (command != null) {
        await _commandRunner.run(command);
      }
    } catch (e) {
      rethrow;
    }
  }
}
