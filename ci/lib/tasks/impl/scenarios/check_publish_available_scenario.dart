import 'package:ci/domain/command.dart';
import 'package:ci/domain/config.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/services/parsers/command_parser.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/checks.dart';
import 'package:ci/tasks/core/task.dart';

/// Сценарий для команды check_publish_available.
///
/// Пример вызова:
/// dart ci check_publish_available --name=anyName
class CheckPublishAvailableScenario extends Scenario {
  static const String commandName = 'check_publish_available';
  static const String nameOption = CommandParser.defaultNameOption;

  final PubspecParser _pubspecParser;

  CheckPublishAvailableScenario(Command command, this._pubspecParser)
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
              'ожидалось check_publish_available --name=anyName',
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

      /// проверяем возможность публикации
      await checkPublishAvailable(element);
    } on BaseCiException {
      rethrow;
    }
  }
}
