import 'package:ci/domain/dependency.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/tasks/core/task.dart';

/// Строки для визуализации зависимостей в консоле.
const String _arrowDep = ' | ';
const String _arrow = ' ---->';

class ShowDependencyGraphTask extends Action {
  final List<Element> elements;

  ShowDependencyGraphTask(this.elements) : assert(elements != null);

  @override
  Future<void> run() async {
    /// Хранит данные для вывода в консоль
    final str = StringBuffer();
    for (var element in elements) {
      _createOutputOnConsole(element, str, -_arrowDep.length);
      str.write('\n');
    }
    print(str);
  }

  /// Если у элемнета есть зависимости "флаттер стандарта", то генерим строку для вывода в консоль.
  void _createOutputOnConsole(Element element, StringBuffer str, int indentLength) {
    str.write(element.name);
    if (_getDependency(element).isNotEmpty) {
      str.write(_arrow);
      indentLength += element.name.length + _arrow.length + _arrowDep.length;
      _dependencyOutputOnConsole(
        element,
        str,
        indentLength,
      );
    }
  }

  ///  Зависимости рекурсивно добавляем в вывод
  void _dependencyOutputOnConsole(Element element, StringBuffer str, int indentLength) {
    var dependencies = _getDependency(element);
    for (var i = 0; i < dependencies.length; i++) {
      i == 0 ? str.write(_arrowDep) : str.write('\n' + ' ' * indentLength + _arrowDep);
      _createOutputOnConsole(dependencies[i].element, str, indentLength);
    }
  }

  /// Список зависимостей "флаттер стандарта" у элемента
  List<Dependency> _getDependency(Element element) {
    var dependencies = <Dependency>[];
    for (var dependency in element.dependencies) {
      if (!dependency.thirdParty) {
        dependencies.add(dependency);
      }
    }
    return dependencies;
  }
}
