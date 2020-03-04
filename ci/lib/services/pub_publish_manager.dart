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

/// Публикует [Element] на сервер.
/// [pathServer] - можно указать свой сервер для публикации,
/// подробнее о сервере [https://dart.dev/tools/pub/cmd/pub-lish]
Future<ProcessResult> runPubPublish(Element element, {String pathServer}) {
  return sh(
    'pub publish --force',
    arguments: pathServer != null ? ['--server', '$pathServer'] : [],
    path: element.path,
  );
}
