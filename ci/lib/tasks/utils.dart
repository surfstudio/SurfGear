import 'package:ci/domain/element.dart';
import 'package:ci/services/runner/shell_runner.dart';

/// Получить модули, помеченные как stable.
List<Element> getStableModules(List<Element> elements) {
  return elements.where((e) => e.isStable).toList();
}

/// Ищет изменения в указанных модулях, опираясь на разницу
/// между двумя последними коммитами.
Future<List<Element>> findChangedElements(List<Element> elements) async {
  await markChangedElements(elements);

  return filterChangedElements(elements);
}

/// Возвращает элеметны из списка, которые имеют отметку об изменении.
Future<List<Element>> filterChangedElements(List<Element> elements) async {
  return elements.where((e) => e.changed).toList();
}

/// Помечает измененные модули, опираясь на разницу
/// между двумя последними коммитами.
Future<void> markChangedElements(List<Element> elements) async {
  final result = await sh('git diff --name-only HEAD HEAD~');
  final diff = result.stdout as String;

  print('Файлы, изменённые в последнем коммите:\n$diff');

  elements
      .where(
        (e) => diff.contains(e.directoryName),
      )
      .toList()
      .forEach(
        (e) => e.changed = true,
      );
}
