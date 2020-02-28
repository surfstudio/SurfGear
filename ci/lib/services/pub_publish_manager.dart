import 'dart:io';

import 'package:ci/domain/element.dart';
import 'package:ci/services/runner/shell_runner.dart';

/// Для [Element] запускает проверку на возможность публикации пакета
Future<ProcessResult> runDryPublish(Element element) {
  return sh(
    'pub publish --dry-run',
    path: element.path,
  );
}

/// Для [Element] запускает проверку на возможность публикации пакета
Future<ProcessResult> runPubPublish(Element element, {String pathServer}) {
  var urlServer = pathServer == null ? '' : '--server $pathServer';
  return sh(
    'pub publish $urlServer',
    path: element.path,
  );
}
