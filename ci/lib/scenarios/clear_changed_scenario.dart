import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/core/scenario.dart';
import 'package:ci/tasks/utils.dart';

const String _helpInfo = 'Deletes a file with a list of modified files.';

/// Сценарий очистки файла со списком измненнных элементов.
/// Данный сценарий необходимо вызывать в самом конце пайплайна.
///
/// Пример вызова:
/// dart ci clear_changed
class ClearChangedScenario extends Scenario {
  static const String commandName = 'clear_changed';

  ClearChangedScenario(Command command, PubspecParser pubspecParser) : super(command, pubspecParser);

  @override
  Future<void> run() async {
    await clearChangedListFile();
  }

  /// Метод пуст по причине того, что данный сценарий полностью выбивается
  /// из общего флоу использования сценариев - он не использует список элементов,
  /// ему не нужна валидация и тд, он просто выполняет очистку лишних файлов.
  /// Поэтому чтобы не выполнялись лишние операции переопределен
  /// именно метод запуска.
  ///
  /// ВНИМАНИЕ!!! Метод вызван не будет.
  @override
  Future<void> doExecute(List<Element> elements) async {}

  @override
  String get getCommandName => commandName;

  @override
  String get helpInfo => _helpInfo;
}
