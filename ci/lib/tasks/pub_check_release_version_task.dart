import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/services/pub_publish_manager.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:ci/utils/process_result_extension.dart';

/// Ищем этот текст
const String _findText = 'CHANGELOG.md doesn\'t mention current version';

/// Проверяем, совпадает ли версия [Element] c прописанной CHANGELOG.md
class PubCheckReleaseVersionTask extends Check {
  final Element _element;

  PubCheckReleaseVersionTask(this._element) : assert(_element != null);

  @override
  Future<bool> run() async {
    var processResult = await runDryPublish(_element);
    if (processResult.exitCode != 0) {
      processResult.print();

      if (processResult.stderr.contains(_findText)) {
        return Future.error(
          ModuleNotReadyReleaseVersion(
            getPubCheckReleaseVersionExceptionText(
              _element.name.toString(),
            ),
          ),
        );
      }
      return Future.error(
        ModuleNotReadyReleaseVersionFail(
          getPubCheckReleaseVersionFailExceptionText(
            _element.name.toString(),
          ),
        ),
      );
    }

    return true;
  }
}
