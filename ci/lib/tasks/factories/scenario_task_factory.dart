import 'package:ci/domain/command.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:ci/tasks/impl/scenarios/licensing_check_scenario.dart';

/// Фабрика для создания сценариев.
class ScenarioTaskFactory {
  /// Создает сценарий по переданной команде.
  Scenario create(Command command) {
    switch (command.name) {
      case LicensingCheckScenario.commandName:
        return LicensingCheckScenario(command, PubspecParser());

      default:
        return null;
    }
  }
}
