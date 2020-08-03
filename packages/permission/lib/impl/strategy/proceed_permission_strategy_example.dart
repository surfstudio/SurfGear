import 'package:permission/base/permission_manager.dart';
import 'package:permission/base/strategy/proceed_permission_strategy.dart';

/// Class with example strategy of proceed permission.
/// Do not use it! It's just example.
class ProceedPermissionStrategyExample implements ProceedPermissionStrategy {
  @override
  Future<void> proceed(
    Permission permission,
    PermissionStrategyStatus status,
  ) async {
    if (status == PermissionStrategyStatus.allow) {
      // ignore: avoid_print
      print('We have permission - $permission.');
    } else {
      // ignore: avoid_print
      print('Try get permission from user. $permission');
    }
  }
}
