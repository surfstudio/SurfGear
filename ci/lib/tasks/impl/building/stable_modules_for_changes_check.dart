import 'package:ci/domain/element.dart';
import 'package:ci/tasks/core/task.dart';

/// Проверяет изменился ли модуль, отмеченный как stable.
class CheckStableModuleForChanges implements Check {
  final Element element;

  CheckStableModuleForChanges(this.element) : assert(element.isStable);

  @override
  Future<bool> run() async => element.changed;
}
