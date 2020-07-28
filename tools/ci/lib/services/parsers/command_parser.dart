import 'package:args/args.dart';
import 'package:ci/domain/command.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
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
import 'package:ci/utils/arg_results_extension.dart';
import 'package:ci/utils/string_util.dart';

/// Парсер команд
class CommandParser {
  static const String defaultAllFlag = 'all';
  static const String defaultNameOption = 'name';

  /// Флаг для вызова help
  static const String helpFlag = 'help';
  static const String helpAbbr = 'h';
  final ArgParser _argParser = ArgParser();

  CommandParser() {
    _initParser();
  }

  /// Выполняет парсинг переданных аргументов и возвращает команду на исполнение.
  Future<Command> parse(List<String> arguments) async {
    var parsedArgs = _argParser.parse(arguments);

    if (parsedArgs.rest.isNotEmpty) {
      return Future.error(
        ParseCommandException(
          getParseCommandExceptionText(
            arguments.join(defaultStringSeparator),
          ),
        ),
      );
    }

    var command = await _getCommandByArgs(parsedArgs);

    if (command == null) {
      return Future.error(
        ParseCommandException(
          getParseCommandExceptionText(
            arguments.join(defaultStringSeparator),
          ),
        ),
      );
    }

    return command;
  }

  /// В данном методе необходимо провести инициализацию
  /// у парсера всевозможных опций.
  void _initParser() {
    /// check_licensing
    _argParser
      ..addCommand(
        CheckLicensingScenario.commandName,
        ArgParser()
          ..addFlag(
            CheckLicensingScenario.allFlag,
            negatable: false,
            help: CheckLicensingScenario.helpAllFlag,
          )
          ..addOption(
            CheckLicensingScenario.nameOption,
            help: CheckLicensingScenario.helpNameOption,
          ),
      )

      /// build
      ..addCommand(BuildScenario.commandName)

      /// add_license
      ..addCommand(AddLicenseScenario.commandName)

      /// add_copyrights
      ..addCommand(AddCopyrightsScenario.commandName)

      /// check_linter
      ..addCommand(CheckLinterScenario.commandName)

      /// check_publish_available
      ..addCommand(CheckPublishAvailableScenario.commandName)

      /// check_version_in_release_note
      ..addCommand(CheckVersionInReleaseNoteScenario.commandName)

      /// check_dependencies_stable
      ..addCommand(CheckDependenciesStableScenario.commandName)

      /// check_stability_not_changed
      ..addCommand(CheckStabilityNotChangedInDevScenario.commandName)

      /// check_stable_modules_not_changed
      ..addCommand(CheckStableModulesNotChangedScenario.commandName)

      /// check_cyrillic_in_changelog
      ..addCommand(CheckCyrillicInChangelogScenario.commandName)

      /// write_release_note
      ..addCommand(WriteReleaseNoteScenario.commandName)

      /// upgrade_project_tag
      ..addCommand(UpgradeProjectTagScenario.commandName)

      /// find_changed_modules
      ..addCommand(
        FindChangedModulesScenario.commandName,
        ArgParser()
          ..addOption(
            FindChangedModulesScenario.targetOptionName,
            help: FindChangedModulesScenario.helpTargetOptionName,
          ),
      )

      /// increment_unstable
      ..addCommand(IncrementUnstableVersionsScenario.commandName)

      /// increment_dev_unstable
      ..addCommand(IncrementDevUnstableVersionsScenario.commandName)

      /// clear_changed
      ..addCommand(ClearChangedScenario.commandName)

      /// run_tests
      ..addCommand(RunTestScenario.commandName)

      ///publish
      ..addCommand(
          PublishModulesScenario.commandName,
          ArgParser()
            ..addOption(
              PublishModulesScenario.server,
              help: PublishModulesScenario.helpServer,
            )
          ..addOption(
            PublishModulesScenario.isStableOptionName,
            help: PublishModulesScenario.helpIsStable,
          )
      )


      /// graph dependency
      ..addCommand(
          ShowDependencyGraphScenario.commandName,
          ArgParser()
            ..addFlag(ShowDependencyGraphScenario.allFlag,
                negatable: false, help: 'Check all modules')
            ..addOption(ShowDependencyGraphScenario.nameOption,
                help: 'Show dependency graph of the specified module'))

      /// help
      ..addFlag(helpFlag, negatable: false, abbr: helpAbbr)

      //mirror
      ..addCommand(MirrorOpenSourceModuleScenario.commandName);
  }

  /// Проверяем, требовался ли вызов help, если нет, то запускаем команду
  Future<Command> _getCommandByArgs(ArgResults results) async {
    var command = results.command;

    var isShowHelp = results[CommandParser.helpFlag] as bool;

    if (isShowHelp) {
      return Command(ShowHelpScenario.commandName, <String, dynamic>{
        ShowHelpScenario.parser: _argParser,
        ShowHelpScenario.results: command,
      });
    }

    if (command == null) {
      return null;
    }

    switch (command.name) {
      default:
        return Command(command.name, command.getParsed());
    }
  }
}
