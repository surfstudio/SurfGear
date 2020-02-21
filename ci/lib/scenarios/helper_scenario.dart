import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/core/scenario.dart';
import 'package:ci/tasks/core/task.dart';

/// Выводит help по командам в консоль
class HelperScenario extends Scenario {
  static const String flag = 'help';
  static const String abbrFlag = 'h';
  static const String commandName = 'showHelper';

  HelperScenario(Command command, PubspecParser pubspecParser) : super(command, pubspecParser);

  @override
  Future<void> doExecute(List<Element> elements) {
    showHelper();
    return null;
  }

  void showHelper() {
    print('add_copyrights               Adds copyrights to files to the transferred modules.');
    print('add_license                  Adds the transferred license modules.');
    print('build                        Builds the transferred modules.');
    print('check_dependencies_stable    Checking the stability of module dependencies.');
  }
}
