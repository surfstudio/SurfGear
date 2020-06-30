import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/checks.dart';
import 'package:ci/tasks/core/scenario.dart';

/// Сценарий для команды check_publish_available.
///
/// Пример вызова:
/// dart ci check_publish_available
class CheckPublishAvailableScenario extends ChangedElementScenario {
  static const String commandName = 'check_publish_available';

  @override
  Map<String, String> getCommandsHelp() => {
        commandName: 'Checking for the possibility of publishing the openSource module package.',
      };

  CheckPublishAvailableScenario(Command command, PubspecParser pubspecParser) : super(command, pubspecParser);

  Future<void> handleElement(Element element) async {
    try {
      await checkPublishAvailable(element);
    } on BaseCiException {
      rethrow;
    }
  }

  @override
  Future<void> doExecute(List<Element> elements) async {
    try {
      for (var element in elements) {
        await checkPublishAvailable(element);
      }
    } on BaseCiException {
      rethrow;
    }
  }

  @override
  String get getCommandName => commandName;
}
