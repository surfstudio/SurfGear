import 'dart:io';

import 'package:ci/exceptions/exceptions.dart';

/// Стратегии обработки ошибки
/// [StackTrace]
typedef ErrorHandlingStrategies = Future<void> Function(Exception exception, StackTrace stackTrace);

/// Стратегия для неизвестных ошибок
Future<void> _strategyForUnknownErrors(Exception exception, StackTrace stackTrace) {
  print('unknownErrorStrategy: ${exception}');
  return Future.error(exception, stackTrace);
}

/// Стандартная стратегия обработки ошибок
Future<void> _standardErrorHandlingStrategy(Exception exception, StackTrace stackTrace) async {
  print(exception);
  exitCode = 1;
}

Map<Type, ErrorHandlingStrategies> _mapErrorStrategy = {
  BaseCiException: _standardErrorHandlingStrategy,
  Exception: _strategyForUnknownErrors,
};

Map<Type, ErrorHandlingStrategies> get mapErrorStrategy => _mapErrorStrategy;
