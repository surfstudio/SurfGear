import 'package:args/args.dart';
import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/core/scenario.dart';
import 'package:ci/tasks/factories/scenario_helper.dart';

/// Выводит help команд в консоль
class ShowHelpScenario extends Scenario {
  static const String commandName = 'showHelpScenario';
  static const String parser = 'parser';
  static const String results = 'results';

  ShowHelpScenario(
    Command command,
    PubspecParser pubspecParser,
  ) : super(command, pubspecParser);

  @override
  Future<void> run() async {
    var argResults = command.arguments[results];
    var argParser = command.arguments[parser];
    var stringBuffer = StringBuffer();
    var keys = argParser.commands.keys.toList();
    if (argResults != null) {
      stringBuffer.write(_createBufferHelp(await scenarioMap[argResults.name](null, null)));
    } else {
      var helpCommands = getHelpList(keys, argParser);
      var maxLengthNameCommand = _getMaxLengthCommandName(keys);




//      var scenarios = await _getScenarios();
//      var maxLengthNameCommand = _getMaxLengthCommandName(scenarios);
//
//      for (var scenario in scenarios) {
//        stringBuffer.write(_createBufferHelp(scenario, maxLengthNameCommand));
//      }
    }

    print(stringBuffer);
  }

  List<Map<String, String>> getHelpList(List<String> keys, ArgParser argParser) {
    var _helpCommands = <Map<String, String>>[];
    argParser = command.arguments[parser];
    for (var key in keys) {
      _helpCommands.add(scenarioMap[key](null, null).getHelpMap(argParser.commands[key]));
    }
    return _helpCommands;
  }

  int _getMaxLengthCommandName(List<String> keys) {
    var maxLengthNameCommand = 0;
    for (var key in keys) {
      maxLengthNameCommand = maxLengthNameCommand > key.length ? maxLengthNameCommand : key.length;
    }
    return maxLengthNameCommand;
  }

//  Future<List<Scenario>> _getScenarios() async {
//    var scenarios = <Scenario>[];
//    _argParser = command.arguments[parser];
//    var keys = _argParser.commands.keys.toList();
//    for (var key in keys) {
//      scenarios.add(await scenarioMap[key](null, null));
//    }
//    return scenarios;
//  }

  /// Считаем колличество табов эквивалетное
  /// самой длинной команде.
//  int _getMaxLengthCommandName(List<Scenario> scenarios) {
//    var maxLengthNameCommand = 0;
//    for (var scenario in scenarios) {
//      var lengthNameCommand = scenario.getCommandName.length;
//      maxLengthNameCommand =
//          maxLengthNameCommand > lengthNameCommand ? maxLengthNameCommand : lengthNameCommand;
//    }
//    return maxLengthNameCommand;
//  }

  /// Создаём хелп для каждой команды
  StringBuffer _createBufferHelp(Scenario scenario, [int maxLengthNameCommand = 0]) {
    var stringBuffer = StringBuffer();
//    _mapHelp = scenario.getHelp(_argParser.commands[scenario.getCommandName]);
//    stringBuffer.write(scenario.getCommandName);
//				stringBuffer.write(_mapHelp.)

//    stringBuffer.write(scenario.getCommandName);
//    var lengthNameCommand = (maxLengthNameCommand - scenario.getCommandName.length).abs();
//    stringBuffer.write(' ' * lengthNameCommand + '\t\t');
//    stringBuffer.write(scenario.helpInfo);
//    stringBuffer.write('\n');
//    var strHelp = _argParser.commands[scenario.getCommandName].usage;
//    if (strHelp.isNotEmpty) {
//      stringBuffer.write(strHelp + '\n');
//    }

    return stringBuffer;
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
  String get getCommandName =>
      throw NotSupportedMethodCallException(getNotSupportedMethodCallExceptionText('getCommandName'));

  @override
  String get helpInfo =>
      throw NotSupportedMethodCallException(getNotSupportedMethodCallExceptionText('helpInfo'));
}
