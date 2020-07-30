import 'package:ci/scenarios/add_copyrights_scenario.dart';
import 'package:ci/scenarios/add_license_scenario.dart';
import 'package:ci/scenarios/build_scenario.dart';
import 'package:ci/scenarios/check_cyrillic_in_changelog_scenario.dart';
import 'package:ci/scenarios/check_dependencies_stable_scenario.dart';
import 'package:ci/scenarios/check_licensing_scenario.dart';
import 'package:ci/scenarios/check_linter_scenario.dart';
import 'package:ci/scenarios/check_publish_available_scenario.dart';
import 'package:ci/scenarios/check_stability_not_changed_in_dev_scenario.dart';
import 'package:ci/scenarios/check_stable_modules_not_changed_scenario.dart';
import 'package:ci/scenarios/check_version_in_release_note_scenario.dart';
import 'package:ci/scenarios/clear_changed_scenario.dart';
import 'package:ci/scenarios/find_changed_modules_scenario.dart';
import 'package:ci/scenarios/increment_dev_unstable_versions_scenario.dart';
import 'package:ci/scenarios/increment_unstable_versions_scenario.dart';
import 'package:ci/scenarios/mirror_opensource_module_scenario.dart';
import 'package:ci/scenarios/publish_unstable_modules_scenario.dart';
import 'package:ci/scenarios/run_test_scenario.dart';
import 'package:ci/scenarios/show_dependency_graph_scenario.dart';
import 'package:ci/scenarios/show_help_scenario.dart';
import 'package:ci/scenarios/upgrade_project_tag_scenario.dart';
import 'package:ci/scenarios/write_release_note_scenario.dart';
import 'package:ci/tasks/factories/scenario_task_factory.dart';

/// Набор методов и значений для работы со сценариями

Map<String, ScenarioBuilder> scenarioMap = <String, ScenarioBuilder>{
  PublishModulesScenario.commandName: (command, parser) =>
      PublishModulesScenario(command, parser),
  CheckLicensingScenario.commandName: (command, parser) =>
      CheckLicensingScenario(command, parser),
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
  CheckStableModulesNotChangedScenario.commandName: (command, parser) =>
      CheckStableModulesNotChangedScenario(command, parser),
  CheckCyrillicInChangelogScenario.commandName: (command, parser) =>
      CheckCyrillicInChangelogScenario(command, parser),
  WriteReleaseNoteScenario.commandName: (command, parser) =>
      WriteReleaseNoteScenario(command, parser),
  UpgradeProjectTagScenario.commandName: (command, parser) =>
      UpgradeProjectTagScenario(command, parser),
  RunTestScenario.commandName: (command, parser) =>
      RunTestScenario(command, parser),
  FindChangedModulesScenario.commandName: (command, parser) =>
      FindChangedModulesScenario(command, parser),
  ClearChangedScenario.commandName: (command, parser) =>
      ClearChangedScenario(command, parser),
  IncrementUnstableVersionsScenario.commandName: (command, parser) =>
      IncrementUnstableVersionsScenario(command, parser),
  IncrementDevUnstableVersionsScenario.commandName: (command, parser) =>
      IncrementDevUnstableVersionsScenario(command, parser),
  ShowHelpScenario.commandName: (command, parser) =>
      ShowHelpScenario(command, parser),
  ShowDependencyGraphScenario.commandName: (command, parser) =>
      ShowDependencyGraphScenario(command, parser),
  MirrorOpenSourceModuleScenario.commandName: (command, parser) =>
      MirrorOpenSourceModuleScenario(command, parser),
};
