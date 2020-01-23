import 'dart:io';

import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/runner/shell_runner.dart';
import 'package:ci/helper/process_result_extension.dart';

/// Проверка на возможность публикации пакета  модулей openSource
class DryRunTask {
  Future<void> run(List<Element> elements) async {
    final messages = [];

    for (var element in elements) {
      if (element.hosted) {
        final result = await _getProcessResult(element);
        result.print();
        if (result.exitCode != 0) {
          messages
              .add(element.name.toString() + ' ' + result.stderr.toString());
        }
      }
    }
    if (messages.isNotEmpty) {
      _printMessages(messages);
    }
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
