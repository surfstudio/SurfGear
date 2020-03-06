import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/exceptions/exceptions_strings.dart';
import 'package:ci/services/pub_publish_manager.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:ci/utils/process_result_extension.dart';

/// Задача производящая публикацию модуля на сервер.
///
/// [pathServer] - можно указать свой сервер для публикации,
/// если не указан, то публикуется на сервер [https://pub.dev/]
class PubPublishModuleTask extends Action {
  final Element _element;
  final PubPublishManager _pubManager;
  final String _pathServer;

  PubPublishModuleTask(this._element, this._pubManager, {String pathServer})
      : _pathServer = pathServer,
        assert(_element != null),
        assert(_pubManager != null);

  @override
  Future<void> run() async {
    final result = await _pubManager.runPubPublish(
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
