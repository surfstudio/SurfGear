import 'package:ci/exceptions/exceptions.dart';

typedef errorStrategy = void Function(BaseCiException exc);

void baseErrorStrategy(BaseCiException exc) {
  print('baseHandling');
}

void unknownErrorStrategy(BaseCiException exc) {
  print('unknownExceptionHandling');
}

void _licenseFileNotFoundExceptionErrorStrategy(BaseCiException exc) {
  print('licenseFileNotFoundExceptionHandling');
}

void _modulesNotFoundExceptionErrorStrategy(BaseCiException exc) {
  print('modulesNotFoundExceptionHandling');
}

Map<Type, errorStrategy> _mapErrorStrategy = {
  LicenseFileNotFoundException: _licenseFileNotFoundExceptionErrorStrategy,
  ModulesNotFoundException: _modulesNotFoundExceptionErrorStrategy,
  Exception: _modulesNotFoundExceptionErrorStrategy,
};

Map<Type, errorStrategy> get mapErrorStrategy => _mapErrorStrategy;
