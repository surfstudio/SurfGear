class ModulesNotFoundException implements Exception {
  final String message;

  ModulesNotFoundException(this.message);
}

class StableModulesWasModifiedException implements Exception {
  final String message;

  StableModulesWasModifiedException(this.message);
}

class ModuleNotReadyForOpenSours implements Exception {
  final String message;

  ModuleNotReadyForOpenSours(this.message);
}
