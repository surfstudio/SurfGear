import 'package:permission/permission.dart';

/// Запрашивает разрешения определённых типов
abstract class PermissionHandler {
  bool canHandle(Permission permission);

  /// Запрос разрешения.
  /// Возвращает [true], если разрешение есть.
  /// Если [checkRationale], то выбросит [FeatureProhibitedException] в случае
  /// повторного отказа от использования фичи и последующего запрета.
  /// (Актуально только для Android, на iOS выбрасывается всегда.)
  Future<bool> request(Permission permission, {bool checkRationale});

  /// Проверка разрешения без запроса
  Future<bool> check(Permission permission);
}
