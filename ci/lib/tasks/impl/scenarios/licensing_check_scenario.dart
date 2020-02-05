import 'package:ci/domain/command.dart';
import 'package:ci/domain/config.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
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

  final PubspecParser _pubspecParser;

  LicensingCheckScenario(Command command, this._pubspecParser) : super(command);

  @override
  Future<void> run() async {
    var args = command.arguments;

    /// валидация аргументов
    var isArgCorrect = await validateCommandParamForElements(args);

    if (!isArgCorrect) {
      return Future.error(
        CommandParamsValidationException(
          getCommandFormatExceptionText(commandName,
              'ожидалось check_licensing --all или check_licensing --name=anyName'),
        ),
      );
    }

    /// получаем все элементы
    var elements = _pubspecParser.parsePubspecs(Config.packagesPath);

    /// Фильтруем по переданным параметрам список элементов
    elements = await filterElementsByCommandParams(elements, command.arguments);

    /// Валидируем лицензирование по отфильтрованному списку
    await checkLicensing(elements);
  }
}
