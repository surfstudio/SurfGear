import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/services/parsers/command_parser.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/services/runner/command_runner.dart';
import 'package:ci/tasks/factories/scenario_task_factory.dart';

/// Приложение для Continuous Integration.
///
/// TODO: было бы не плохо чтоб всё это жило дольше чем выполнение 1 команды,
/// тогда бы мы могли единовременно выполнять инициализацию
/// и использовать некоторое окружение
class Ci {
  static Ci _instance;

  static Ci get instance => _instance ??= Ci._();

  CommandParser _commandParser;
  CommandRunner _commandRunner;

  Ci.init({CommandParser commandParser, CommandRunner commandRunner}) {
    _instance ??= Ci._(
      commandParser: commandParser,
      commandRunner: commandRunner,
    );
  }

  Ci._({
    CommandParser commandParser,
    CommandRunner commandRunner,
  })  : _commandParser = commandParser ?? CommandParser(),
        _commandRunner = commandRunner ?? CommandRunner(ScenarioTaskFactory());

  /// Выполняет действие исходя из переданных параметров.
  Future<void> execute(List<String> arguments) async {
    var command;
    try {
      command = await _commandParser.parse(arguments);
    } on ParseCommandException {
      rethrow;
    }

    return _commandRunner.run(command);
  }
}
