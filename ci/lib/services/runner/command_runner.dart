import 'package:ci/domain/command.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/tasks/factories/scenario_task_factory.dart';

/// Утилита для запуска [Command]
class CommandRunner {
  final ScenarioTaskFactory _scenarioTaskFactory;

  CommandRunner(this._scenarioTaskFactory);

  /// Запускает команду на выполнение.
  Future<void> run(Command command) async {
    var scenario = _scenarioTaskFactory.create(command);

    if (scenario == null) {
      return Future.error(
        CommandHandlerNotFoundException(
          getCommandHandlerNotFoundExceptionText(
            command.name,
          ),
        ),
      );
    }

    return scenario.run();
  }
}
