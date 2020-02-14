import 'package:ci/tasks/factories/scenario_task_factory.dart';
import 'package:ci/tasks/impl/scenarios/add_copyrights_scenario.dart';
import 'package:ci/tasks/impl/scenarios/add_license_scenario.dart';
import 'package:ci/tasks/impl/scenarios/build_scenario.dart';
import 'package:ci/tasks/impl/scenarios/check_dependencies_stable_scenario.dart';
import 'package:ci/tasks/impl/scenarios/check_linter_scenario.dart';
import 'package:ci/tasks/impl/scenarios/check_publish_available_scenario.dart';
import 'package:ci/tasks/impl/scenarios/check_stability_not_changed_in_dev_scenario.dart';
import 'package:ci/tasks/impl/scenarios/check_version_in_release_note_scenario.dart';
import 'package:ci/tasks/impl/scenarios/licensing_check_scenario.dart';
import 'package:ci/tasks/impl/scenarios/upgrade_project_tag_scenario.dart';

/// Набор методов и значений для работы со сценариями

Map<String, ScenarioBuilder> scenarioMap = <String, ScenarioBuilder>{
  LicensingCheckScenario.commandName: (command, parser) =>
      LicensingCheckScenario(command, parser),
  BuildScenario.commandName: (command, parser) =>
      BuildScenario(command, parser),
  AddLicenseScenario.commandName: (command, parser) =>
      AddLicenseScenario(command, parser),
  AddCopyrightsScenario.commandName: (command, parser) =>
      AddCopyrightsScenario(command, parser),
  CheckLinterScenario.commandName: (command, parser) =>
      CheckLinterScenario(command, parser),
  CheckPublishAvailableScenario.commandName: (command, parser) =>
      CheckPublishAvailableScenario(command, parser),
  CheckVersionInReleaseNoteScenario.commandName: (command, parser) =>
      CheckVersionInReleaseNoteScenario(command, parser),
  CheckDependenciesStableScenario.commandName: (command, parser) =>
      CheckDependenciesStableScenario(command, parser),
  CheckStabilityNotChangedInDevScenario.commandName: (command, parser) =>
      CheckStabilityNotChangedInDevScenario(command, parser),
  UpgradeProjectTagScenario.commandName: (command, parser) =>
      UpgradeProjectTagScenario(command, parser),
};
