import 'package:ci/domain/command.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:ci/tasks/impl/scenarios/add_copyrights_scenario.dart';
import 'package:ci/tasks/impl/scenarios/add_license_scenario.dart';
import 'package:ci/tasks/impl/scenarios/build_scenario.dart';
import 'package:ci/tasks/impl/scenarios/check_dependencies_stable_scenario.dart';
import 'package:ci/tasks/impl/scenarios/check_linter_scenario.dart';
import 'package:ci/tasks/impl/scenarios/check_publish_available_scenario.dart';
import 'package:ci/tasks/impl/scenarios/check_stability_not_changed_in_dev_scenario.dart';
import 'package:ci/tasks/impl/scenarios/check_version_in_release_note_scenario.dart';
import 'package:ci/tasks/impl/scenarios/licensing_check_scenario.dart';

/// Фабрика для создания сценариев.
class ScenarioTaskFactory {
  /// Создает сценарий по переданной команде.
  Scenario create(Command command) {
    switch (command.name) {
      case LicensingCheckScenario.commandName:
        return LicensingCheckScenario(command, PubspecParser());

      case BuildScenario.commandName:
        return BuildScenario(command, PubspecParser());

      case AddLicenseScenario.commandName:
        return AddLicenseScenario(command, PubspecParser());

      case AddCopyrightsScenario.commandName:
        return AddCopyrightsScenario(command, PubspecParser());

      case CheckLinterScenario.commandName:
        return CheckLinterScenario(command, PubspecParser());

      case CheckPublishAvailableScenario.commandName:
        return CheckPublishAvailableScenario(command, PubspecParser());

      case CheckVersionInReleaseNoteScenario.commandName:
        return CheckVersionInReleaseNoteScenario(command, PubspecParser());

      case CheckDependenciesStableScenario.commandName:
        return CheckDependenciesStableScenario(command, PubspecParser());

      case CheckStabilityNotChangedInDevScenario.commandName:
        return CheckStabilityNotChangedInDevScenario(command, PubspecParser());

      default:
        return null;
    }
  }
}
