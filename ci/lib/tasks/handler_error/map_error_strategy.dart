import 'dart:io';

import 'package:ci/exceptions/exceptions.dart';

/// Стратегии обработки ошибки
typedef errorStrategy<T extends BaseCiException> = Future<void> Function(T exception);

Future<void> _baseErrorStrategy(BaseCiException exc) async {
  await print('baseHandling');
  exitCode = 1;
}

Future<void> unknownErrorStrategy(Exception exc) async {
  await print('unknownExceptionHandling');
  exitCode = 1;
}

Map<Type, errorStrategy> _mapErrorStrategy = {
  BaseCiException: _baseErrorStrategy,
};

Map<Type, errorStrategy> get mapErrorStrategy => _mapErrorStrategy;
