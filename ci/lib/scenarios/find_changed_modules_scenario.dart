import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/core/scenario.dart';
import 'package:ci/tasks/utils.dart';

const String _helpInfo = 'Builds the transferred modules.';

/// Сценарий поиска измененных элементов и записи списка в файл.
/// Данный сценарий должен быть обязательно вызван в начале пайплайна.
///
/// Пример вызова:
/// dart ci find_changed_modules --target=target_branch_name
class FindChangedModulesScenario extends Scenario {
  static const String commandName = 'find_changed_modules';
  static const String targetOptionName = 'target';

  FindChangedModulesScenario(Command command, PubspecParser pubspecParser) : super(command, pubspecParser);

  @override
  Future<void> validate(Command command) async {
    var args = command.arguments;

    /// валидация аргументов
    var target = args[targetOptionName];

    if (target == null) {
      return Future.error(
        CommandParamsValidationException(
          getCommandFormatExceptionText(
            commandName,
            'ожидалось find_changed_modules --target=target_branch_name',
          ),
        ),
      );
    }
  }

  @override
  Future<void> doExecute(List<Element> elements) async {
    await createChangedListFile(elements, command.arguments[targetOptionName]);
  }

  @override
  // TODO: implement getCommandName
  String get getCommandName => commandName;

  @override
  // TODO: implement helpInfo
  String get helpInfo => _helpInfo;
}
