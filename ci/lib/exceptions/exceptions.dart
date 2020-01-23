class ModulesNotFoundException implements Exception {
  final String message;

  ModulesNotFoundException(this.message);
}

class StableModulesWasModifiedException implements Exception {
  final String message;

  StableModulesWasModifiedException(this.message);
}

class PackageBuildException implements Exception {
  final String message;

  PackageBuildException(this.message);
}