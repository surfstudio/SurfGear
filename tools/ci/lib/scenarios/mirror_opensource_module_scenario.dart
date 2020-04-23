import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/core/scenario.dart';
import 'package:ci/tasks/tasks.dart';

/// Сценарий мирроринга релизных библиотек в отдельтный репо.
/// Требует запуска find_changed перед собой.
///
/// dart ./tools/ci/bin/main.dart mirror
class MirrorOpenSourceModuleScenario extends ChangedElementScenario {
  static const String commandName = 'mirror';

  MirrorOpenSourceModuleScenario(Command command, PubspecParser pubspecParser) : super(command, pubspecParser);

  @override
  Future<void> doExecute(List<Element> elements) {
    return mirrorOpenSourceModules(elements);
  }

  @override
  String get getCommandName => commandName;

  @override
  Map<String, String> getCommandsHelp() {
    return {
      commandName: 'Mirror opensource module to separate repo. Run after find_changed.'
    };
  }

}