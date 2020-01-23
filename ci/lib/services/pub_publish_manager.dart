import 'dart:io';

import 'package:ci/domain/element.dart';
import 'package:ci/runner/shell_runner.dart';

/// Для [Element] проверку на возможность публикации пакета
Future<ProcessResult> checkDryRun(Element element) {
  return sh('pub publish --dry-run', path: element.path);
}
