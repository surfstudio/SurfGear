import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/services/pub_publish_manager.dart';
import 'package:ci/tasks/core/task.dart';

/// Проверяем, совпадает ли версия [Element] c прописанной CHANGELOG.md
class PubCheckReleaseVersionTask extends Check {
  /// Ищем данный текст в результате
  static const String _checkVersion = 'CHANGELOG.md doesn\'t mention current version';
  final Element element;

  PubCheckReleaseVersionTask(this.element) : assert(element != null);

  @override
  Future<bool> run() async {
    var resultsLog = '';
    var processResult = await runDryPublish(element);
    if (processResult.toString().contains(_checkVersion)) {
      resultsLog = element.name.toString();
    }
    if (resultsLog.isNotEmpty) {
      _printMessages(resultsLog);
      return false;
    }
    return true;
  }

  void _printMessages(String messages) {
    throw ModuleNotReadyReleaseVersion(
      'Модули, с непрописанной версией Release Notes: \n\t' + messages + '\n',
    );
  }
}
