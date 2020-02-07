import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/services/parsers/command_parser.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/checks.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:ci/tasks/utils.dart';

/// Сценарий для команды check_licensing.
///
/// Пример вызова:
/// dart ci check_licensing --name=push / dart ci check_licensing --all
class LicensingCheckScenario extends Scenario {
  static const String commandName = 'check_licensing';
  static const String allFlag = CommandParser.defaultAllFlag;
  static const String nameOption = CommandParser.defaultNameOption;

  LicensingCheckScenario(Command command, PubspecParser pubspecParser)
      : super(command, pubspecParser);

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
            'ожидалось check_licensing --all или check_licensing --name=anyName',
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
      /// Валидируем лицензирование по отфильтрованному списку
      await checkLicensing(elements);
    } on BaseCiException {
      rethrow;
    }
  }
}
