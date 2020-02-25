import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/core/scenario.dart';
import 'package:ci/tasks/tasks.dart';
import 'package:ci/tasks/utils.dart';

/// Сценарий для команды build.
///
/// Пример вызова:
/// dart ci build
class BuildScenario extends ChangedElementScenario {
  static const String commandName = 'build';

  BuildScenario(
    Command command,
    PubspecParser pubspecParser,
  ) : super(
          command,
          pubspecParser,
        );

  @override
  Future<void> doExecute(List<Element> elements) {
    /// запускаем сборку для полученного списка
    return build(elements);
  }
}
