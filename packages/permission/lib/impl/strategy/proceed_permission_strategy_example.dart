import 'package:permission/base/permission_manager.dart';
import 'package:permission/base/strategy/proceed_permission_strategy.dart';

/// Class with example strategy of proceed permission.
/// Do not use it! It's just example.
class ProceedPermissionStrategyExample implements ProceedPermissionStrategy {
  @override
  Future<void> proceed(Permission permission, PermissionStrategyStatus status) {
    if (status == PermissionStrategyStatus.allow) {
      print("We have permision - $permission.");
    } else {
      print("Try get permission from user. $permission");
    }

    return null;
  }
}
