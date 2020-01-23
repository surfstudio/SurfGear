import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/services/pub_publish_manager.dart';
import 'package:ci/tasks/core/task.dart';

/// Проверяем, совпадает ли версия изменённых [Element]
class PubCheckReleaseVersionTask extends Check {
  final List<Element> elements;

  PubCheckReleaseVersionTask(this.elements) : assert(elements != null);

  @override
  Future<bool> run() async {
    var resultsLog = [];
    for (var element in elements) {
      var processResult = await checkDryRun(element);
      if (processResult
          .toString()
          .contains('CHANGELOG.md doesn\'t mention current version')) {
        resultsLog.add(element.name.toString());
      }
    }

    if (resultsLog.isNotEmpty) {
      _printMessages(resultsLog);
      return false;
    }
    return true;
  }

  /// Выводим список ошибок
  void _printMessages(List<String> messages) {
    throw ModuleNotReadyReleaseVersion(
        'Модуль с непорописанной версией Release Notes: ' +
            messages.join('\n'));
  }
}
