import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/checks.dart';
import 'package:ci/tasks/core/scenario.dart';

/// Сценарий для команды check_dependencies_stable.
///
/// Пример вызова:
/// dart ci check_dependencies_stable
class CheckDependenciesStableScenario extends Scenario {
  static const String commandName = 'check_dependencies_stable';

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

  @override
  Future<void> doExecute(List<Element> elements) async {
    try {
      for (var element in elements) {
        /// Проверяем что зависимости элемента стабильны
        await checkDependenciesStable(element);
      }
    } on BaseCiException {
      rethrow;
    }
  }
}
