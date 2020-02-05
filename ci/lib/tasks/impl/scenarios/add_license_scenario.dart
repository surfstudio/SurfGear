import 'package:ci/domain/command.dart';
import 'package:ci/domain/config.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:ci/tasks/tasks.dart';

/// Сценарий для команды add_license.
///
/// Пример вызова:
/// dart ci add_license
class AddLicenseScenario extends Scenario {
  static const String commandName = 'add_license';

  final PubspecParser _pubspecParser;

  AddLicenseScenario(Command command, this._pubspecParser) : super(command);

  @override
  Future<void> run() async {
    /// получаем все элементы
    var elements = _pubspecParser.parsePubspecs(Config.packagesPath);

    /// Добавляем лиценизии
    await addLicense(elements);
  }
}
