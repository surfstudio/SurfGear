import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/checks.dart';
import 'package:ci/tasks/core/scenario.dart';

const String _helpInfo = 'Builds the transferred modules.';

/// Сценарий для команды check_cyrillic_in_changelog.
///
/// Пример вызова:
/// dart ci check_cyrillic_in_changelog
class CheckCyrillicInChangelogScenario extends Scenario {
  static const String commandName = 'check_cyrillic_in_changelog';

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

  @override
  String get helpInfo => _helpInfo;
}
