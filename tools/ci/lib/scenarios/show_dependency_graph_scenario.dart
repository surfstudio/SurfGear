import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/services/parsers/command_parser.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/checks.dart';
import 'package:ci/tasks/core/scenario.dart';
import 'package:ci/tasks/utils.dart';

/// Выводит в консоль граф зависимостей елемента.
///
/// dart ci deps / dart ci deps --name=anyName
class ShowDependencyGraphScenario extends Scenario {
  static const String commandName = 'deps';
  static const String allFlag = CommandParser.defaultAllFlag;
  static const String nameOption = CommandParser.defaultNameOption;

  @override
  Map<String, String> getCommandsHelp() => {
        commandName: 'Show module dependency graph.',
      };

  ShowDependencyGraphScenario(
    Command command,
    PubspecParser pubspecParser,
  ) : super(command, pubspecParser);

  @override
  Future<void> validate(Command command) async {
    var args = command.arguments;

    /// валидация аргументов
    var isArgCorrect = await validateCommandParamForElements(args);

    if (!isArgCorrect) {
      return Future.error(
        CommandParamsValidationException(
          getCommandFormatExceptionText(
            commandName,
            'ожидалось deps --all или deps --name=anyName',
          ),
        ),
      );
    }
  }

  @override
  Future<List<Element>> preExecute() async {
    var elements = await super.preExecute();

    /// Фильтруем по переданным параметрам список элементов
    return filterElementsByCommandParams(
      elements,
      command.arguments,
    );
  }

  @override
  Future<void> doExecute(List<Element> elements) async {
    try {
      await showDependencyGraph(elements);
    } on BaseCiException {
      rethrow;
    }
  }

  @override
  String get getCommandName => commandName;
}
