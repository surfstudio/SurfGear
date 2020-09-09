import 'package:ci/domain/dependency.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/tasks/core/task.dart';

/// Обновляет Element в зависимых модулях
class UpdateVersionsDependingOnModuleTask implements Action {
  /// Все элементы
  final List<Element> _elements;

  /// Элементы, которым нужно обновить зависимость
  final List<Element> _updateElements;

  UpdateVersionsDependingOnModuleTask(this._elements, this._updateElements)
      : assert(_elements != null),
        assert(_updateElements != null);

  @override
  Future<List<Element>> run() async {
    final updatedElement = <Element>[];
    _updateElements.forEach((Element updateElement) {
      updatedElement.add(_updateDependence(updateElement));
    });
    return updatedElement;
  }

  Element _updateDependence(Element updateElement) {
    final newDependency = <Dependency>[];

    updateElement.dependencies.forEach(
      (Dependency dependency) {
        _elements.forEach(
          (Element element) {
            if (dependency is HostedDependency && !dependency.thirdParty) {
              if (dependency.element?.name == element.name &&
                  dependency.version != element.version) {
                newDependency.add(_newDependency(dependency, element));
              }
            }
          },
        );
      },
    );

    return Element.byTemplate(updateElement, dependencies: newDependency);
  }

  Dependency _newDependency(Dependency oldDependency, Element newElement) {
    switch (oldDependency.runtimeType) {
      case HostedDependency:
        return HostedDependency.byTemplate(
          oldDependency,
          element: newElement,
          version: newElement.version,
        );
      default:
        return oldDependency;
    }
  }
}
