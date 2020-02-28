import 'package:args/args.dart';
import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
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
  Future<void> run() async {
    ArgParser _argParser = command.arguments[parser];
    ArgResults _argResults = command.arguments[results];
    if (_argResults != null) {
      await _show(_argResults.name);
    } else {
      var keys = _argParser.commands.keys.toList();
      var maxLengthCommandName = _getMaxLengthCommandName(keys);
      for (var key in keys) {
        await _show(key, maxLengthCommandName);
      }
    }
  }

  /// Считаем колличество табов эквивалетное
  /// самой длинной команде.
  int _getMaxLengthCommandName(List<String> keys) {
    var maxLengthNameCommand = 0;
    for (var key in keys) {
      var lengthNameCommand = scenarioMap[key](null, null).getCommandName.length;
      if (maxLengthNameCommand < lengthNameCommand) {
        maxLengthNameCommand = lengthNameCommand;
      }
    }
    return maxLengthNameCommand;
  }

  Future<void> _show(String key, [int amountTab = 0]) async {
    await scenarioMap[key](null, null).showHelpCommand(amountTab);
  }

  /// Метод пуст по причине того, что данный сценарий полностью выбивается
  /// из общего флоу использования сценариев - он не использует список элементов,
  /// ему не нужна валидация и тд, он просто показывает help для всех комманд.
  /// Поэтому чтобы не выполнялись лишние операции переопределен
  /// именно метод запуска.
  ///
  /// ВНИМАНИЕ!!! Метод вызван не будет.
  ///
  @override
  Future<void> doExecute(List<Element> elements) async {}

  @override
  String get getCommandName => '';

  @override
  String get helpInfo => '';
}
