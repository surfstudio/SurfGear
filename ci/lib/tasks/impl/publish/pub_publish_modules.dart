import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/services/pub_publish_manager.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:ci/utils/process_result_extension.dart';

/// Команда на паблишинг модулей
class PubPublishModules extends Action {
  final String _pathServer;
  final Element _element;

  PubPublishModules(this._element, {String pathServer})
      : _pathServer = pathServer,
        assert(_element != null);

  @override
  Future<void> run() async {
    final result = await runPubPublish(
      _element,
      pathServer: _pathServer,
    );
    result.print();
    if (result.exitCode != 0) {
      return Future.error(
        OpenSourceModuleCanNotBePublishException(
          getModuleCannotBePublishedExceptionText(_element.name),
        ),
      );
    }
  }
}
