import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';

/// Проверяет изменились ли модули, отмеченные как stable.
/// Если есть изменённые — выбрасывает исключение со списком модулей.
void checkStableModulesForChanges(List<Element> elements) {
  final changedModules =
      elements.where((e) => e.isStable && e.changed).toList();

  if (changedModules.isNotEmpty) {
    final modulesNames = changedModules.map((e) => e.name).join(', ');
    throw StableModulesWasModifiedException(
        'Модули, отмеченные как stable, были изменены: $modulesNames');
  }
}
