import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/checks.dart';
import 'package:ci/tasks/core/scenario.dart';

const String _helpInfo = 'Checking for the possibility of publishing the openSource module package';

/// Сценарий для команды check_publish_available.
///
/// Пример вызова:
/// dart ci check_publish_available
class CheckPublishAvailableScenario extends ChangedElementScenario {
  static const String commandName = 'check_publish_available';

  CheckPublishAvailableScenario(Command command, PubspecParser pubspecParser) : super(command, pubspecParser);

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

  @override
  String get helpInfo => _helpInfo;
}
