import 'package:ci/domain/command.dart';
import 'package:ci/domain/config.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/services/parsers/command_parser.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/checks.dart';
import 'package:ci/tasks/core/task.dart';

/// Сценарий для команды check_dependencies_stable.
///
/// Пример вызова:
/// dart ci check_dependencies_stable --name=anyName
class CheckDependenciesStableScenario extends Scenario {
  static const String commandName = 'check_dependencies_stable';
  static const String nameOption = CommandParser.defaultNameOption;

  final PubspecParser _pubspecParser;

  CheckDependenciesStableScenario(Command command, this._pubspecParser)
      : super(command);

  @override
  Future<void> run() async {
    try {
      /// валидация аргументов
      var elementName = command.arguments[nameOption];

      if (elementName == null) {
        return Future.error(
          CommandParamsValidationException(
            getCommandFormatExceptionText(
              commandName,
              'ожидалось check_dependencies_stable --name=anyName',
            ),
          ),
        );
      }

      /// получаем все элементы
      var elements = _pubspecParser.parsePubspecs(Config.packagesPath);

      var element = elements.firstWhere(
        (e) => e.name == elementName,
        orElse: () => null,
      );

      if (element == null) {
        return Future.error(
          ElementNotFoundException(
            getElementNotFoundExceptionText(elementName),
          ),
        );
      }

      /// Проверяем что зависимости элемента стабильны
      await checkDependenciesStable(element);
    } on BaseCiException {
      rethrow;
    }
  }
}
