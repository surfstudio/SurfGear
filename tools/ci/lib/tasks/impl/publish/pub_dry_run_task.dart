import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/services/pub_publish_manager.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:ci/utils/process_result_extension.dart';

/// Проверка на возможность публикации пакета модулей openSource
class PubDryRunTask extends Check {
  final Element _element;
  final PubPublishManager _pubManager;

  PubDryRunTask(this._element, this._pubManager)
      : assert(_element != null),
        assert(_pubManager != null);

  @override
  Future<bool> run() async {
    if (_element.hosted) {
      final result = await _pubManager.runDryPublish(_element);
      result.print();
      if (result.exitCode != 0) {
        return Future.error(
          OpenSourceModuleCanNotBePublishException(
            getOpenSourceModuleCanNotBePublishExceptionText(_element.name),
          ),
        );
      }
    } else {
      return false;
    }
    return true;
  }
}
