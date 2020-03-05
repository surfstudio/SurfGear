import 'package:init_project/services/command_parser.dart';
import 'package:init_project/services/command_runner.dart';
import 'package:init_project/services/directory_manager.dart';

class InitProject {
  static InitProject _instance;

  static InitProject get instance => _instance ??= InitProject._();
  CommandParser _commandParser;

  CommandRunner _commandRunner;

  InitProject._({
    CommandParser commandParser,
    CommandRunner commandRunner,
  })  : _commandParser = commandParser ?? CommandParser(),
        _commandRunner = commandRunner ??
            CommandRunner(
              DirectoryManager(),
            );

  InitProject.init({
    CommandParser commandParser,
    CommandRunner commandRunner,
  }) {
    _instance ??= InitProject._(
      commandParser: commandParser,
      commandRunner: commandRunner,
    );
  }

  Future<void> execute(List<String> arguments) async {
    try {
      var command = await _commandParser.parser(arguments);
      await _commandRunner.run(command);
    } catch (e) {
      rethrow;
    }
  }
}
