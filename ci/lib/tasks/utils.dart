import 'package:ci/domain/element.dart';

/// Получить модули, помеченные как stable.
List<Element> getStableModules(List<Element> elements) {
  return elements.where((e) => e.isStable).toList();
}
