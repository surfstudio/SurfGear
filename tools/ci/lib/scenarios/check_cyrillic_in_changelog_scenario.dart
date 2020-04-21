import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/checks.dart';
import 'package:ci/tasks/core/scenario.dart';

/// Сценарий для команды check_cyrillic_in_changelog.
///
/// Пример вызова:
/// dart ci check_cyrillic_in_changelog
class CheckCyrillicInChangelogScenario extends ChangedElementScenario {
  static const String commandName = 'check_cyrillic_in_changelog';

  @override
  Map<String, String> getCommandsHelp() => {
        commandName: 'Checking the presence of Cyrillic in the file CHANGELOG.md.',
      };

  CheckCyrillicInChangelogScenario(Command command, PubspecParser pubspecParser)
      : super(command, pubspecParser);

  @override
  Future<void> doExecute(List<Element> elements) async {
    try {
      for (var element in elements) {
        /// Проверяем changelog на наличие кириллических символов
        await checkCyrillicChangelog(element);
      }
    } on BaseCiException {
      rethrow;
    }
  }

  @override
  String get getCommandName => commandName;
}
