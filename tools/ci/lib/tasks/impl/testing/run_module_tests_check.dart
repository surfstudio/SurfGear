import 'dart:io';

import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/services/runner/shell_runner.dart';
import 'package:ci/tasks/core/task.dart';

/// Запуск теста с помощью `flutter test`.
/// Выбрасывает сообщение об ошибке, если тест провален.
class RunModuleTests implements Check {
  final Element element;

  RunModuleTests(this.element);

  @override
  Future<bool> run() async {
    final analyzeResult = await sh(
      'flutter test',
      path: element.uri.toFilePath(windows: Platform.isWindows),
    );

    if (analyzeResult.exitCode != 0) {
      final out = analyzeResult.stdout;
      final err = analyzeResult.stderr;

      throw TestsFailedException('${element.name}\n$out$err\n\n');
    }

    return true;
  }
}
