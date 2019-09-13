/// Типы сборок приложения
/// При сборке из CLI регулируются сборокой из
/// соответствующего файла main-\***.dart
/// ```
///   flutter build *** -t lib/main-***.dart
/// ```
///
enum BuildType { debug, release, qa }
