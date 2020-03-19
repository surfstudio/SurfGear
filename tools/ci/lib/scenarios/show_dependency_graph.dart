import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/services/parsers/command_parser.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/core/scenario.dart';

const String _arrowDep = ' |-> ';

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
    /// Содержит мапу с зависимостями елементов
    var mapGraph = <Element>[];

    /// Хранит данные для вывода в консоль
    final str = StringBuffer();
    var el = <Element>[];
//    el.add(elements[0]);
//    el.add(elements[1]);
//    el.add(elements[2]);
//    el.add(elements[3]);
//    el.add(elements[4]);
//    el.add(elements[5]);
    el.add(elements[7]);
    el.add(elements[6]);
//    el.add(elements[0]);
//    el.add(elements[8]);
    el.add(elements[10]);
    el.add(elements[11]);
    _test(elements, str);
    print(str);


  }

  void _test(List<Element> elements, StringBuffer str, [int parentLength = 0]) {
    var length = _getLengthMaxName(elements) + parentLength;
    for (var element in elements) {
      str.write('\n' + element.name);
      if (_isDependency(element)) {
        var space = _getLine(length, element);
        str.write(space);
        print(length + space.length);
        _dep(element, str, length + _arrowDep.length - 1);
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

  void _dep(Element element, StringBuffer str, int length) {
    var deps = element.dependencies;
    var depElement = <Element>[];
    for (var i = 0; i < deps.length; i++) {
      var dep = deps[i];

      if (!dep.thirdParty) {
        i == 0
            ? str.write(_arrowDep + dep.element.name)
            : str.write('\n' + ' ' * length + '$_arrowDep' + dep.element.name);
        _dep(dep.element, str, length);
      }
    }
  }

  /// Возвращает максимальную длину имени из списка имен
  int _getLengthMaxName(List<Element> elements) {
    var maxLength = 0;
    for (var element in elements) {
      if (element.name.length > maxLength) {
        maxLength = element.name.length;
      }
    }
    return maxLength;
  }

  String _getLine(int maxLength, Element element) {
    var difference = maxLength - element.name.length;
    return '-' * difference + '--->';
  }

  @override
  String get getCommandName => commandName;

  @override
  String get helpInfo => 'show module dependency graph';
}
