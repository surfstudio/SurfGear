import 'package:args/args.dart';
import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/core/scenario.dart';
import 'package:ci/tasks/factories/scenario_helper.dart';

/// Дефолтный отступ
const String _wTab = '\t\t';

/// Выводит help команд в консоль, включая опций и субкоманд
///
/// dart ci --help / dart ci -h
class ShowHelpScenario extends Scenario {
  static const String commandName = 'showHelpScenario';

  /// key для
  static const String parser = 'parser';
  static const String results = 'results';

  ShowHelpScenario(
    Command command,
    PubspecParser pubspecParser,
  ) : super(command, pubspecParser);

  @override
  Map<String, String> getCommandsHelp() => throw NotSupportedMethodCallException(
      getNotSupportedMethodCallExceptionText('ShowHelpScenario#getCommandName'));

  /// Проверяем, запрошен общий хелп или для одной команды
  @override
  Future<void> run() async {
    ArgResults argResults = command.arguments[results];
    ArgParser argParser = command.arguments[parser];
    var helpBuffer = StringBuffer();

    if (argResults != null) {
      var nameCommand = argResults.name;
      var maxLengthNames = _getMaxLengthNames(nameCommand);
      helpBuffer.write(_getInfoCommand(nameCommand, maxLengthNames, argParser));
    } else {
      var keys = argParser.commands.keys.toList();
      var maxLengthNames = _getMaxLengthNames(keys);
      for (var key in keys) {
        helpBuffer.write(_getInfoCommand(key, maxLengthNames, argParser));
      }
    }
    print(helpBuffer);
  }

  /// Собираем хелп для указанной команды
  StringBuffer _getInfoCommand(String nameCommand, int maxLengthNames, ArgParser argParser) {
    var mapHelp = scenarioMap[nameCommand](null, null).getHelp(argParser.commands[nameCommand]);
    return _generate(mapHelp, maxLengthName: maxLengthNames);
  }

  /// Генерируем хелпу рекурсивно
  StringBuffer _generate(Map<String, dynamic> mapHelp, {int maxLengthName, int lineIndent = 0}) {
    var helpBuffer = StringBuffer();
    var keys = mapHelp.keys.toList();

    for (var key in keys) {
      if (mapHelp[key] is! Map<String, dynamic>) {
        helpBuffer.write(_wTab * lineIndent);
        helpBuffer.write(key);
        helpBuffer.write(_getIndent(maxLengthName, key));
        helpBuffer.write(mapHelp[key]);
        helpBuffer.write('\n');
      } else {
        Map<String, dynamic> subMapHelp = mapHelp[key];
        var maxLengthNames = _getMaxLengthNames(subMapHelp.keys.toList());
        helpBuffer.write(_generate(subMapHelp, maxLengthName: maxLengthNames, lineIndent: ++lineIndent));
      }
    }
    return helpBuffer;
  }

  ///  Определяет максимальную длинну команды, для корректного вывода в консоль
  int _getMaxLengthNames(dynamic namesCommands) {
    if (namesCommands is List<String>) {
      var maxLengthNameCommand = 0;
      for (var key in namesCommands) {
        maxLengthNameCommand = maxLengthNameCommand > key.length ? maxLengthNameCommand : key.length;
      }
      return maxLengthNameCommand;
    }
    return (namesCommands as String).length;
  }

  /// Возвращает общий отступ для всех команд, ориентируясь на самое длинное имя
  String _getIndent(int maxLengthName, String name) {
    var lengthNameCommand = (maxLengthName - name.length).abs();
    return ' ' * lengthNameCommand + '\t\t';
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

  /// [ShowHelpScenario] не должен возвращать имя и хелп
  @override
  String get getCommandName => throw NotSupportedMethodCallException(
      getNotSupportedMethodCallExceptionText('ShowHelpScenario#getCommandName'));
}
