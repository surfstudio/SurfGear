import 'dart:io';

import 'package:ci/exceptions/exceptions.dart';

/// Стратегии обработки ошибки
typedef ErrorStrategy = Future<void> Function(Exception exception, StackTrace stackTrace);

Future<void> unknownErrorStrategy(Exception exception, StackTrace stackTrace) async {
  exitCode = 1;
  return Future.error(exception, stackTrace,);
}

Future<void> _baseErrorStrategy(Exception exception, StackTrace stackTrace) async {
  await print(stackTrace);
  exitCode = 1;
}

Map<Type, ErrorStrategy> _mapErrorStrategy = {
  BaseCiException: _baseErrorStrategy,
};

Map<Type, ErrorStrategy> get mapErrorStrategy => _mapErrorStrategy;
