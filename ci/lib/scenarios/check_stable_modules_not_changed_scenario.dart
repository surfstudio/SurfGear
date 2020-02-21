import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/checks.dart';
import 'package:ci/tasks/core/scenario.dart';

/// Сценарий для команды check_stable_modules_not_changed.
///
/// Пример вызова:
/// dart ci check_stable_modules_not_changed
class CheckStableModulesNotChangedScenario extends ChangedElementScenario {
  static const String commandName = 'check_stable_modules_not_changed';

  CheckStableModulesNotChangedScenario(
      Command command,
      PubspecParser pubspecParser,
      ) : super(
    command,
    pubspecParser,
  );

  @override
  Future<void> doExecute(List<Element> elements) async {
    try {
      /// проверяем, что стабильные модули не поменялись
      await checkStableModulesForChanges(elements);
    } on BaseCiException {
      rethrow;
    }
  }
}
