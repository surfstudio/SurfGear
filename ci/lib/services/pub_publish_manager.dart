import 'dart:io';

import 'package:ci/domain/element.dart';
import 'package:ci/services/runner/shell_runner.dart';

/// Для [Element] проверка на возможность публикации пакета
Future<ProcessResult> runDryPublish(Element element) {
  return sh('pub publish --dry-run', path: element.path);
}
