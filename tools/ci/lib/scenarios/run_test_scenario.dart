import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/checks.dart';
import 'package:ci/tasks/core/scenario.dart';

/// Сценарий для команды upgrade_project_tag.
///
/// Пример вызова:
/// dart ci run_tests
class RunTestScenario extends ChangedElementScenario {
  static const String commandName = 'run_tests';

  @override
  Map<String, String> getCommandsHelp() => {
        commandName: 'Running tests in modules.',
      };

  RunTestScenario(
    Command command,
    PubspecParser pubspecParser,
  ) : super(
          command,
          pubspecParser,
        );

  @override
  Future<void> doExecute(List<Element> elements) async {
    try {
      await runTests(elements);
    } on BaseCiException {
      rethrow;
    }
  }

  @override
  String get getCommandName => commandName;
}
