import 'dart:io';

import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/services/runner/shell_runner.dart';
import 'package:ci/tasks/core/task.dart';

/// Проверка модулей с помощью `flutter analyze`.
class CheckModulesWithLinter implements Check {
  final List<Element> elements;

  CheckModulesWithLinter(this.elements);

  @override
  Future<bool> run() async {
    var errorMessages = <String>[];

    for (var element in elements) {
      final analyzeResult = await sh(
        'flutter analyze',
        path: element.uri.toFilePath(windows: Platform.isWindows),
      );

      if (analyzeResult.exitCode != 0) {
        final errorMessage =
            '${analyzeResult.stdout}${analyzeResult.stderr}\n\n';
        errorMessages.add(errorMessage);
      }
    }

    if (errorMessages.isNotEmpty) {
      errorMessages.insert(
          0, 'Пожалуйста, исправьте ошибки в следующих модулях:\n\n');

      return Future.error(
        AnalyzerFailedException(errorMessages.join()),
      );
    }

    return true;
  }
}
