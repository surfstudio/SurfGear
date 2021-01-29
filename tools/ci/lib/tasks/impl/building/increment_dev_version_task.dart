import 'package:ci/domain/element.dart';
import 'package:ci/tasks/core/task.dart';

/// Задача для инкремента dev версии элемента
class IncrementDevVersionTask extends Action {
  final Element element;

  IncrementDevVersionTask(this.element) : assert(element != null);

  @override
  Future<Element> run() async {
    if (!element.isStable && element.changed)
      return Element.byTemplate(
        element,
        version: _getIncrementVersion(element),
      );

    return element;
  }

  ///todo сделать сброс счетчика
  String _getIncrementVersion(Element element) {
    final elementVersionRegex = RegExp('dev\.([0-9]+)');

    final resRegex = elementVersionRegex.allMatches(element.version).toList();

    if (resRegex.isNotEmpty) {
      final resSplit = resRegex.last?.group(0)?.split('.');

      if (resSplit != null && resSplit.length > 1) {
        final increment = _incrementVersion(
          element: element,
          resSplit: resSplit,
          elementVersionRegex: elementVersionRegex,
        );

        if (increment != null) {
          return increment;
        }
      }
    }
    return element.version + '-dev.0';
  }

  String _incrementVersion({
    List<String> resSplit,
    Element element,
    RegExp elementVersionRegex,
  }) {
    int elementVersionNum = int.tryParse(resSplit[1]);
    if (elementVersionNum == null) {
      return null;
    }
    elementVersionNum++;
    return element.version.replaceFirst(
      elementVersionRegex,
      'dev.$elementVersionNum',
    );
  }
}
