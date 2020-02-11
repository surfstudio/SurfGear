import 'dart:io';

import 'package:ci/exceptions/exceptions.dart';

/// Стратегии обработки ошибки
typedef errorStrategy = Future<void> Function(Exception exception, StackTrace stackTrace);

Future<void> unknownErrorStrategy(Exception exception, StackTrace stackTrace) async {
  exitCode = 1;
  throw exception;
}

Future<void> _baseErrorStrategy(Exception exception, StackTrace stackTrace) async {
  print(stackTrace);
  await print('baseHandling');
  exitCode = 1;
}

Map<Type, errorStrategy> _mapErrorStrategy = {
  BaseCiException: _baseErrorStrategy,
};

Map<Type, errorStrategy> get mapErrorStrategy => _mapErrorStrategy;
