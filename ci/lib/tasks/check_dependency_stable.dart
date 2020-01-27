import 'package:ci/domain/element.dart';
import 'package:ci/tasks/core/task.dart';

/// Проверка стабильности зависимостей модуля.
class CheckDependencyStable extends Check {
  final Element _element;

  CheckDependencyStable(this._element);

  @override
  Future<bool> run() async {
    for (var dependency in _element.dependencies) {
      var element = dependency.element;
      if (element != null && !element.isStable) {
        return false;
      }
    }

    return true;
  }
}