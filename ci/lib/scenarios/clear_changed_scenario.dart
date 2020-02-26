import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/core/scenario.dart';
import 'package:ci/tasks/utils.dart';

/// Сценарий очистки файла со списком измненнных элементов.
/// Данный сценарий необходимо вызывать в самом конце пайплайна.
///
/// Пример вызова:
/// dart ci clear_changed
class ClearChangedScenario extends Scenario {
  static const String commandName = 'clear_changed';

  ClearChangedScenario(Command command, PubspecParser pubspecParser)
      : super(command, pubspecParser);

  @override
  Future<void> run() async {
    await clearChangedListFile();
  }

  @override
  Future<void> doExecute(List<Element> elements) async {}
}
