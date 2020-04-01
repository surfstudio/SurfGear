import 'package:ci/domain/element.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:ci/tasks/utils.dart';

/// Строки для визуализации зависимостей в консоле.
const String _arrowDep = ' | ';
const String _arrow = ' ---->';

/// Задача вывода в консоль информации о зависимостях мужду модулями
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
    if (getDependency(element).isNotEmpty) {
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
    var dependencies = getDependency(element);
    for (var i = 0; i < dependencies.length; i++) {
      i == 0 ? str.write(_arrowDep) : str.write('\n' + ' ' * indentLength + _arrowDep);
      _createOutputOnConsole(dependencies[i].element, str, indentLength);
    }
  }
}
