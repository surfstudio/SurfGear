import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/core/task.dart';

/// Проверяет изменились ли модули, отмеченные как stable.
/// Если есть изменённые — выбрасывает исключение со списком модулей.
class CheckStableModulesForChanges implements Check {
  final List<Element> elements;

  CheckStableModulesForChanges(this.elements);

  @override
  Future<bool> run() {
    final changedModules =
        elements.where((e) => e.isStable && e.changed).toList();

    if (changedModules.isNotEmpty) {
      final modulesNames = changedModules.map((e) => e.name).join(', ');
      return Future.error(
        StableModulesWasModifiedException(
            'Модули, отмеченные как stable, были изменены: $modulesNames'),
      );
    }

    return Future.value(true);
  }
}
