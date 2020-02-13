import 'package:ci/services/parsers/command_parser.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/services/runner/command_runner.dart';
import 'package:ci/tasks/factories/scenario_helper.dart';
import 'package:ci/tasks/factories/scenario_task_factory.dart';
import 'package:ci/tasks/handler_error/standard_error_handler.dart';
import 'package:ci/tasks/handler_error/strategies_errors.dart';
import 'package:ci/tasks/handler_error/strategy_factory_errors.dart';

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
  StandardErrorHandler _standardErrorHandler;

  Ci.init({
    CommandParser commandParser,
    CommandRunner commandRunner,
    StandardErrorHandler standardErrorHandler,
  }) {
    _instance ??= Ci._(
      commandParser: commandParser,
      commandRunner: commandRunner,
      standardErrorHandler: standardErrorHandler,
    );
  }

  Ci._({
    CommandParser commandParser,
    CommandRunner commandRunner,
    StandardErrorHandler standardErrorHandler,
  })  : _commandParser = commandParser ?? CommandParser(),
        _commandRunner = commandRunner ??
            CommandRunner(
              ScenarioTaskFactory(
                pubspecParser: PubspecParser(),
                buildMap: scenarioMap,
              ),
            ),
        _standardErrorHandler = standardErrorHandler ??
            StandardErrorHandler(
              StrategyFactoryErrors(
                mapErrorStrategy,
                strategyForUnknownErrors,
                standardErrorHandlingStrategy,
              ),
            );

  /// Выполняет действие исходя из переданных параметров.
  Future<void> execute(List<String> arguments) async {
    var command;
    try {
      command = await _commandParser.parse(arguments);
      await _commandRunner.run(command);
    } catch (e, stackTrace) {
      await _standardErrorHandler.handle(e, stackTrace);
    }
  }
}
