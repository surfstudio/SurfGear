import 'package:ci/domain/element.dart';
import 'package:ci/tasks/core/task.dart';

/// Задача для инкремента dev версии элемента
class IncrementDevVersionTask extends Action {
  final Element element;

  IncrementDevVersionTask(this.element) : assert(element != null);

  @override
  Future<Element> run() async {
    if (!element.isStable && element.changed) {
      return Element.byTemplate(
        element,
        version: _getIncrementVersion(),
      );
    }

    return Element.byTemplate(
      element,
      version: _getIncrementVersion(breakVersion: true),
    );
  }

  String _getIncrementVersion({bool breakVersion = false}) {
    var elementVersionRegex = RegExp('dev\.([0-9])');
    var elementVersionNum = int.parse(
        elementVersionRegex.firstMatch(element.version).group(0).split('.')[1]);

    elementVersionNum++;

    var versionString = element.version.replaceFirst(
      elementVersionRegex,
      'dev.${breakVersion ? 0 : elementVersionNum}',
    );

    return versionString;
  }
}
