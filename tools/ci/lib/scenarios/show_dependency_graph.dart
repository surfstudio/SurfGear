import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/services/parsers/command_parser.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/core/scenario.dart';

const String _arrowDep = ' | ';
const String _arrow = ' ---->';

///  Выводит в консоль граф зависимостей елемента
///
/// dart ci graph / dart ci graph --name=anyName
class ShowDependencyGraph extends Scenario {
  static const String commandName = 'graph';
  static const String nameOption = CommandParser.defaultNameOption;

  ShowDependencyGraph(
    Command command,
    PubspecParser pubspecParser,
  ) : super(command, pubspecParser);

  @override
  Future<void> doExecute(List<Element> elements) async {
    /// Хранит данные для вывода в консоль
    final str = StringBuffer();

    for (var element in elements) {
      str.write('\n');
      _test(element, str, -_arrowDep.length);
    }
    print(str);
  }

  void _test(Element element, StringBuffer str, int length) {
    str.write(element.name);
    if (_isDependency(element)) {
      str.write(_arrow);
      _dep(element, str, length + element.name.length + _arrow.length + _arrowDep.length);
    }
  }

  void _dep(Element element, StringBuffer str, int length) {
    var dependencies = element.dependencies;
    for (var i = 0; i < dependencies.length; i++) {
      var dep = dependencies[i];

      if (!dep.thirdParty) {
        i == 0 ? str.write(_arrowDep) : str.write('\n' + ' ' * length + '$_arrowDep');
        _test(dep.element, str, length);
      }
    }
  }

  bool _isDependency(Element element) {
    for (var dep in element.dependencies) {
      if (!dep.thirdParty) {
        return true;
      }
    }
    return false;
  }

  @override
  String get getCommandName => commandName;

  @override
  String get helpInfo => 'show module dependency graph';
}
