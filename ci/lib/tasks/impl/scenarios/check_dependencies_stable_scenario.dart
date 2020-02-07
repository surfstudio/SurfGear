import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
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
class CheckDependenciesStableScenario extends OneElementScenario {
  static const String commandName = 'check_dependencies_stable';
  static const String nameOption = CommandParser.defaultNameOption;

  @override
  String get formatExceptionText => getCommandFormatExceptionText(
        commandName,
        'ожидалось check_dependencies_stable --name=anyName',
      );

  CheckDependenciesStableScenario(
    Command command,
    PubspecParser pubspecParser,
  ) : super(
          command,
          pubspecParser,
        );

  @override
  Future<void> handleElement(Element element) async {
    try {
      /// Проверяем что зависимости элемента стабильны
      await checkDependenciesStable(element);
    } on BaseCiException {
      rethrow;
    }
  }
}
