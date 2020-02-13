import 'package:ci/domain/dependency.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/domain/tag.dart';
import 'package:ci/tasks/core/task.dart';

/// Обновляет зависимости модуля по переданному тегу.
class UpdateDependenciesByTagTask extends Task<Element> {
  final Element _element;
  final ProjectTag _projectTag;

  UpdateDependenciesByTagTask(this._element, this._projectTag);

  @override
  Future<Element> run() async {
    var dependencies = _element.dependencies.map((d) {
      if (d is GitDependency) {
        return GitDependency(
          element: d.element,
          thirdParty: d.thirdParty,
          path: d.path,
          url: d.url,
          ref: _projectTag.tagName
        );
      }

      return d;
    }).toList();
    return Element.byTemplate(_element, dependencies: dependencies);
  }
}
