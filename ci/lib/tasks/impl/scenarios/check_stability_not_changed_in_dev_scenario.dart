import 'package:ci/domain/command.dart';
import 'package:ci/domain/config.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/checks.dart';
import 'package:ci/tasks/core/task.dart';

/// Сценарий для команды check_stability_not_changed.
///
/// Пример вызова:
/// dart ci check_stability_not_changed
class CheckStabilityNotChangedInDevScenario extends Scenario {
  static const String commandName = 'check_stability_not_changed';

  final PubspecParser _pubspecParser;

  CheckStabilityNotChangedInDevScenario(Command command, this._pubspecParser)
      : super(command);

  @override
  Future<void> run() async {
    try {
      /// получаем все элементы
      var elements = _pubspecParser.parsePubspecs(Config.packagesPath);

      /// проверяем, что не поменялась стабильность модулей
      await checkStabilityNotChangeInDev(elements);
    } on BaseCiException {
      rethrow;
    }
  }
}
