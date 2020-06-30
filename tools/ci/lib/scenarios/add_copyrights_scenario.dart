import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/core/scenario.dart';
import 'package:ci/tasks/tasks.dart';

/// Сценарий для команды add_copyrights.
///
/// Пример вызова:
/// dart ci add_copyrights
class AddCopyrightsScenario extends Scenario {
  static const String commandName = 'add_copyrights';

  @override
  Map<String, String> getCommandsHelp() => {
        commandName: 'Adds copyright to files of transferred modules.',
      };

  AddCopyrightsScenario(
    Command command,
    PubspecParser pubspecParser,
  ) : super(
          command,
          pubspecParser,
        );

  @override
  Future<void> doExecute(List<Element> elements) {
    /// Добавляем копирайты
    return addCopyrights(elements);
  }

  @override
  String get getCommandName => commandName;
}
