import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/services/pub_publish_manager.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:ci/utils/process_result_extension.dart';

/// Проверка на возможность публикации пакета  модулей openSource
class DryRunTask extends Check {
  final List<Element> elements;

  DryRunTask(this.elements) : assert(elements != null);

  @override
  Future<bool> run() async {
    final messages = [];
    final openSourceModules =
        elements.where((element) => element.hosted).toList();
    messages.addAll(await _createMessagesException(openSourceModules));
    if (messages.isNotEmpty) {
      _printMessages(messages);
      return false;
    }
    return true;
  }

  /// [Element] возвращем список ошибок
  Future<List<String>> _createMessagesException(
      List<Element> openSourceModules) async {
    final messages = [];
    for (var openSourceModule in openSourceModules) {
      final result = await checkDryRun(openSourceModule);
      result.print();
      if (result.exitCode != 0) {
        messages.add(
            openSourceModule.name.toString() + ': ' + result.stderr.toString());
      }
    }
    return messages;
  }

  /// Выводим список ошибок
  void _printMessages(List<String> messages) {
    throw ModuleNotReadyForOpenSours(messages.join('\n'));
  }
}
