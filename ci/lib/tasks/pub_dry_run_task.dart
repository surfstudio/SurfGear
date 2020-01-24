import 'dart:io';

import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/services/pub_publish_manager.dart';
import 'package:ci/tasks/core/task.dart';
import 'package:ci/utils/process_result_extension.dart';

/// Проверка на возможность публикации пакета модулей openSource
class PubDryRunTask extends Check {
  final List<Element> elements;

  PubDryRunTask(this.elements);

  @override
  Future<bool> run() async {
    final messages = [];
    final openSourceModules = elements.where((element) => element.hosted).toList();
    for (var openSourceModule in openSourceModules) {
      final result = await _getProcessResult(openSourceModule);
      if (result.exitCode != 0) {
        messages.add(
          _getErrorElement(openSourceModule, result),
        );
      }
    }
    if (messages.isNotEmpty) {
      _printMessages(messages);
      return false;
    }
    return true;
  }

  /// Получаем [ProcessResult]  и выводим в консоль результат
  Future<ProcessResult> _getProcessResult(Element openSourceModule) async {
    final result = await runDryPublish(openSourceModule);
    result.print();
    return result;
  }

  /// Возвращает имя [Element] и ошибку
  String _getErrorElement(Element element, ProcessResult result) {
    return element.name.toString() + ': ' + result.stderr.toString();
  }

  /// Выводим список ошибок в консоль
  void _printMessages(List<String> messages) {
    throw ModuleNotReadyForOpenSours(
        'OpenSource модули, не удовлетворяющие требованию publick:\n\t' + messages.join('\n\t'));
  }
}
