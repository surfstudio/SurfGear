import 'dart:io';

import 'package:ci/exceptions/exceptions.dart';

/// Стратегии обработки ошибки
typedef errorStrategy = Future<void> Function(Exception exception);

Future<void> unknownErrorStrategy(Exception exception) async {
  await print('unknownExceptionHandling');
  exitCode = 1;
}

Future<void> _baseErrorStrategy(Exception exception) async {
  await print('baseHandling');
  exitCode = 1;
}

Map<Type, errorStrategy> _mapErrorStrategy = {
  BaseCiException: _baseErrorStrategy,
};

Map<Type, errorStrategy> get mapErrorStrategy => _mapErrorStrategy;
