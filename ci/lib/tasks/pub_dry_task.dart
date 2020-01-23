import 'dart:io';

import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/runner/shell_runner.dart';
import 'package:ci/helper/process_result_extension.dart';

/// Проверка на возможность публикации пакета  модулей openSource
class DryRunTask {
  Future<void> run(List<Element> elements) async {
    final messages = [];

    final openSourceModules =
        elements.where((element) => element.hosted).toList();

    messages.add(await _createMessagesException(openSourceModules));

    if (messages.isNotEmpty) {
      _printMessages(messages);
    }
  }

  Future<List<String>> _createMessagesException(List<Element> openSourceModules) async {
    final messages = [];
    for (var openSourceModule in openSourceModules) {
      final result = await _getProcessResult(openSourceModule);
      result.print();
      if (result.exitCode != 0) {
        messages.add(
            openSourceModule.name.toString() + ' ' + result.stderr.toString());
      }
    }
    return messages;
  }

  /// Ждём результата провеки
  Future<ProcessResult> _getProcessResult(Element element) {
    return sh('pub publish --dry-run', path: element.path);
  }

  /// Выводим список ошибок
  void _printMessages(List<String> messages) {
    throw ModuleNotReadyForOpenSours(messages.join('\n'));
  }
}
