import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/core/scenario.dart';
import 'package:ci/tasks/tasks.dart';

/// Сценарий для команды add_license.
///
/// Пример вызова:
/// dart ci add_license
class AddLicenseScenario extends Scenario {
  static const String commandName = 'add_license';

  @override
  Map<String, String> getCommandsHelp() => {
        commandName: 'Adds license to files of transferred modules.',
      };

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
}
