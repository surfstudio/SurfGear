import 'package:ci/domain/element.dart';
import 'package:ci/tasks/core/task.dart';

/// Задача для увеличения нестабильной версии
class IncrementUnstableVersionTask extends Action {
  final Element element;

  IncrementUnstableVersionTask(this.element) : assert(element != null);

  @override
  Future<Element> run() async {
    if (!element.isStable && element.changed) {
      return Element.byTemplate(element,
          unstableVersion: element.unstableVersion + 1);
    }
    return element;
  }
}
