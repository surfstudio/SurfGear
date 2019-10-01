import 'package:permission/base/permission_handler.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:permission/base/permission_manager.dart';

class NotificationPermissionHandler implements PermissionHandler {
  @override
  bool canHandle(Permission permission) =>
      permission == Permission.notifications;

  @override
  Future<bool> check(Permission permission) =>
      NotificationPermissions.getNotificationPermissionStatus()
          .then((status) => status == PermissionStatus.granted);

  // Не возвращает решение пользователя,
  // статус разрешения необходимо проверять дополнительно
  // с помощью `check()`
  @override
  Future<bool> request(Permission permission, {bool checkRationale}) =>
      NotificationPermissions.requestNotificationPermissions()
          .then((_) => true);
}
