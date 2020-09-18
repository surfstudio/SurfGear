import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/core/scenario.dart';
import 'package:ci/tasks/tasks.dart';

/// Инкрементирует версию в зависимых от модуля элементов рекурсивно.
/// Обновляет Element в [List<Dependency>]
///
/// dart ci update_depending_elements
class UpdateVersionsDependingOnModuleScenario extends ChangedElementScenario {
  static const String commandName = 'update_depending_elements';

  UpdateVersionsDependingOnModuleScenario(
    Command command,
    PubspecParser pubspecParser,
  ) : super(command, pubspecParser);

  @override
  Future<void> doExecute(List<Element> elements) async {
    await updateVersionsDependingOnModule(elements);
  }

  @override
  String get getCommandName => commandName;

  @override
  Map<String, String> getCommandsHelp() => {
        commandName: 'Upgrades the version to depend on the modified module',
      };
}
