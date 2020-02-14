import 'package:ci/services/parsers/command_parser.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/services/runner/command_runner.dart';
import 'package:ci/tasks/factories/scenario_helper.dart';
import 'package:ci/tasks/factories/scenario_task_factory.dart';
import 'package:ci/tasks/handler_error/standard_error_handler_strategies.dart';
import 'package:ci/tasks/handler_error/strategies_errors.dart';
import 'package:ci/tasks/handler_error/error_handling_strategy_factory.dart';

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

  Ci._({
    CommandParser commandParser,
    CommandRunner commandRunner,
    StandardErrorHandlerStrategies standardErrorHandler,
  })  : _commandParser = commandParser ?? CommandParser(),
        _commandRunner = commandRunner ??
            CommandRunner(
              ScenarioTaskFactory(
                pubspecParser: PubspecParser(),
                buildMap: scenarioMap,
              ),
            ),
        _standardErrorHandler = standardErrorHandler ??
            StandardErrorHandlerStrategies(
              ErrorHandlingStrategyFactory(
                mapErrorStrategy,
                standardErrorHandlingStrategy,
                strategyForUnknownErrors,
              ),
            );

  StandardErrorHandlerStrategies _standardErrorHandler;

  Ci.init({
    CommandParser commandParser,
    CommandRunner commandRunner,
    StandardErrorHandlerStrategies standardErrorHandler,
  }) {
    _instance ??= Ci._(
      commandParser: commandParser,
      commandRunner: commandRunner,
      standardErrorHandler: standardErrorHandler,
    );
  }

  /// Выполняет действие исходя из переданных параметров.
  Future<void> execute(List<String> arguments) async {
    var command;
    try {
      command = await _commandParser.parse(arguments);
      await _commandRunner.run(command);
    } on Exception catch (e, stackTrace) {
      await _standardErrorHandler.handle(e, stackTrace);
    }
  }
}
