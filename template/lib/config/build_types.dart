/// Типы сборок приложения
/// При сборке из CLI регулируются сборокой из
/// соответствующего файла main-\***.dart
/// ```
///   flutter build *** -t lib/main-***.dart
/// ```
///
enum BuildType {
  /// Debug build type
  debug,

  /// Release build type
  release,

  /// Qa build type
  qa,
}
