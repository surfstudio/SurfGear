import 'package:ci/domain/command.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/core/scenario.dart';
import 'package:meta/meta.dart';

/// Билдер сценария
typedef ScenarioBuilder = Scenario Function(Command, PubspecParser);

/// Фабрика для создания сценариев.
class ScenarioTaskFactory {
  final PubspecParser pubspecParser;
  final Map<String, ScenarioBuilder> buildMap;

  ScenarioTaskFactory({
    @required this.buildMap,
    @required this.pubspecParser,
  })  : assert(buildMap != null),
        assert(pubspecParser != null);

  /// Создает сценарий по переданной команде.
  Scenario create(Command command) {
    var commandName = command.name;

    if (!buildMap.containsKey(commandName)) {
      return null;
    }

    return buildMap[commandName](command, pubspecParser);
  }
}
