import 'dart:io';

import 'package:ci/domain/element.dart';
import 'package:ci/runner/shell_runner.dart';

/// Для [Element] проверка на возможность публикации пакета
Future<ProcessResult> checkDryRun(Element element) {
  return sh('pub publish --dry-run', path: element.path);
}

/// Возвращает имя [Element] и ошибку
String getErrorElement(Element element, ProcessResult result) {
  return element.name.toString() + ': ' + result.stderr.toString();
}
