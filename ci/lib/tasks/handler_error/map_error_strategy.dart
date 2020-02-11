import 'package:ci/exceptions/exceptions.dart';

typedef errorStrategy = Future<void> Function(BaseCiException exc);

Future<void> baseErrorStrategy(BaseCiException exc) async {
  await print('baseHandling');
}

Future<void> unknownErrorStrategy(BaseCiException exc) async {
  await print('unknownExceptionHandling');
}

Map<Type, errorStrategy> _mapErrorStrategy = {};

Map<Type, errorStrategy> get mapErrorStrategy => _mapErrorStrategy;
