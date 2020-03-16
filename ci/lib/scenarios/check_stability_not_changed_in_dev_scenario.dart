import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/checks.dart';
import 'package:ci/tasks/core/scenario.dart';

/// Сценарий для команды check_stability_not_changed.
///
/// Пример вызова:
/// dart ci check_stability_not_changed
class CheckStabilityNotChangedInDevScenario extends ChangedElementScenario {
  static const String commandName = 'check_stability_not_changed';

  CheckStabilityNotChangedInDevScenario(
    Command command,
    PubspecParser pubspecParser,
  ) : super(
          command,
          pubspecParser,
        );

  @override
  Future<void> doExecute(List<Element> elements) async {
    try {
      /// проверяем, что не поменялась стабильность модулей
      await checkStabilityNotChangeInDev(elements);
    } on BaseCiException {
      rethrow;
    }
  }
}
