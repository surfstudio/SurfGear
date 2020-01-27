import 'package:ci/domain/element.dart';
import 'package:ci/services/pub_publish_manager.dart';
import 'package:ci/tasks/core/task.dart';

/// Проверяем, совпадает ли версия [Element] c прописанной CHANGELOG.md
class PubCheckReleaseVersionTask extends Check {
  final Element element;

  PubCheckReleaseVersionTask(this.element) : assert(element != null);

  @override
  Future<bool> run() async {
    var processResult = await runDryPublish(element);
    if (processResult
        .toString()
        .contains('CHANGELOG.md doesn\'t mention current version')) {
      return Future.error(element.name.toString() +
          ': модуль, с непрописанной версией Release Notes: \n');
    }
    return true;
  }
}
