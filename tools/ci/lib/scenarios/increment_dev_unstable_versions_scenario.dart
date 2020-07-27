import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/checks.dart';
import 'package:ci/tasks/core/scenario.dart';
import 'package:ci/tasks/tasks.dart';

/// Сценарий для команды increment_dev_unstable.
///
/// Пример вызова:
/// dart ci increment_dev_unstable
class IncrementDevUnstableVersionsScenario extends ChangedElementScenario {
  static const String commandName = 'increment_dev_unstable';

  @override
  Map<String, String> getCommandsHelp() => {
        commandName: 'Dev unstable version increase in modules.',
      };

  IncrementDevUnstableVersionsScenario(
    Command command,
    PubspecParser pubspecParser,
  ) : super(command, pubspecParser);

  @override
  Future<void> doExecute(List<Element> elements) async {
    var incrementedList = await incrementDevUnstableVersion(elements);

    /// сохраняем изменения
    await saveElements(incrementedList);

    /// фиксируем изменения на репозитории
    await fixChanges(message: 'Increment dev unstable versions by ci.');
  }

  @override
  String get getCommandName => commandName;
}
