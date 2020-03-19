import 'package:ci/domain/command.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/services/parsers/command_parser.dart';
import 'package:ci/services/parsers/pubspec_parser.dart';
import 'package:ci/tasks/core/scenario.dart';

/// Строки для визуализации зависимостей в консоле.
const String _arrowDep = ' | ';
const String _arrow = ' ---->';

/// Выводит в консоль граф зависимостей елемента.
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
      _createOutputOnConsole(element, str, -_arrowDep.length);
    }
    print(str);
  }

  /// Если у элемнета есть зависимости "флаттер стандарта", то генерим строку для вывода в консоль.
  void _createOutputOnConsole(Element element, StringBuffer str, int length) {
    str.write(element.name);
    if (_isDependency(element)) {
      str.write(_arrow);
      _dependency(element, str, length + element.name.length + _arrow.length + _arrowDep.length);
    }
  }

  ///
  void _dependency(Element element, StringBuffer str, int length) {
    for (var i = 0; i < element.dependencies.length; i++) {
      if (_isDependency(element)) {
        i == 0 ? str.write(_arrowDep) : str.write('\n' + ' ' * length + _arrowDep);
        _createOutputOnConsole(element.dependencies[i].element, str, length);
      }
    }
  }

  /// Есть ли зависимости "флаттер стандарта" у элемента
  bool _isDependency(Element element) {
    for (var dependency in element.dependencies) {
      if (!dependency.thirdParty) {
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
