import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/core/scenario.dart';
import 'package:ci/tasks/tasks.dart';

const String _helpInfo = 'Adds license to files of transferred modules.';

/// Сценарий для команды add_license.
///
/// Пример вызова:
/// dart ci add_license
class AddLicenseScenario extends Scenario {
  static const String commandName = 'add_license';

  AddLicenseScenario(
    Command command,
    PubspecParser pubspecParser,
  ) : super(
          command,
          pubspecParser,
        );

  @override
  Future<void> doExecute(List<Element> elements) {
    /// Добавляем лиценизии
    return addLicense(elements);
  }

  @override
  String get getCommandName => commandName;

  @override
  String get helpInfo => _helpInfo;
}
