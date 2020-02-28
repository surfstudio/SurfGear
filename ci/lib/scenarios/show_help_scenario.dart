import 'package:args/args.dart';
import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/services/parsers/command_parser.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/core/scenario.dart';
import 'package:ci/tasks/factories/scenario_helper.dart';

/// Выводит help команд в консоль
class ShowHelpScenario extends Scenario {
  static const String commandName = 'showHelpScenario';
  static const String parser = 'parser';
  static const String results = 'results';
  final PubspecParser pubspecParser;

  ShowHelpScenario(
    Command command,
    this.pubspecParser,
  ) : super(command, pubspecParser);

  @override
  Future<void> doExecute(List<Element> elements) async {
    ArgParser _argParser = command.arguments[parser];
    ArgResults _argResults = command.arguments[results];
    var _command = Command(CommandParser.helpFlag, null);
    if (_argResults != null) {
      await _show(_argResults.name, _command);
    } else {
      var keys = _argParser.commands.keys.toList();

      for (var key in keys) {
        await _show(key, _command);
      }
    }
  }

  Future<void> _show(String key, Command command) async {
    await scenarioMap[key](command, PubspecParser()).showHelpCommand();
  }

  @override
  String get getCommandName => '';

  @override
  String get helpInfo => '';
}
