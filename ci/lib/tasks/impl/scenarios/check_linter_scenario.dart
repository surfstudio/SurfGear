import 'package:ci/domain/command.dart';
import 'package:ci/domain/config.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/checks.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:ci/tasks/utils.dart';

/// Сценарий для команды check_linter.
///
/// Пример вызова:
/// dart ci check_linter
class CheckLinterScenario extends Scenario {
  static const String commandName = 'check_linter';

  final PubspecParser _pubspecParser;

  CheckLinterScenario(Command command, this._pubspecParser) : super(command);

  @override
  Future<void> run() async {
    try {
      /// получаем все элементы
      var elements = _pubspecParser.parsePubspecs(Config.packagesPath);

      /// ищем измененные элементы и фильтруем
      await markChangedElements(elements);
      elements = await filterChangedElements(elements);

      /// запускаем проверку
      await checkModulesWithLinter(elements);
    } on BaseCiException {
      rethrow;
    }
  }
}
