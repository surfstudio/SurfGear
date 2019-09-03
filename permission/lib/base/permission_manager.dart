enum Permission {
  camera,
  gallery,
  location,
  calendar,
  contacts,
  microphone,
}

/// Сервис запросов и проверки разрешений
abstract class PermissionManager {
  
  /// Запрос разрешения.
  /// Возвращает [true], если разрешение есть.
  /// Если [checkRationale], то выбросит [FeatureProhibitedException] в случае
  /// повторного отказа от использования фичи и последующего запрета.
  /// (Актуально только для Android, на iOS выбрасывается всегда.)
  Future<bool> request(Permission permission, {bool checkRationale});

  /// Проверка разрешения без запроса
  Future<bool> check(Permission permission);

  /// Открытие системных настроек.
  /// Возвращает [true], если экран с настройками был открыт.
  Future<bool> openSettings();
}
