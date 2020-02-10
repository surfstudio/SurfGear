import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/services/pub_publish_manager.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:ci/utils/process_result_extension.dart';

/// Проверка на возможность публикации пакета модулей openSource
class PubDryRunTask extends Check {
  final Element _element;

  PubDryRunTask(this._element) : assert(_element != null);

  @override
  Future<bool> run() async {
    if (_element.hosted) {
      final result = await runDryPublish(_element);
      result.print();
      if (result.exitCode != 0) {
        return Future.error(OpenSourceModuleCanNotBePublishException(
            getOpenSourceModuleCanNotBePublishExceptionText(_element.name.toString())));
      }
    } else {
      return false;
    }
    return true;
  }
}
